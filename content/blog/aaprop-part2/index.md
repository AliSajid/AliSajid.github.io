---
title: "The AAProp Project: Part 2"
subtitle: "The First Implementation"
summary: "In this second part of the AAProp series, I explore the evolution of the Rust REST API. What started as a
monolithic prototype transformed over seven distinct phases into a modular microservice featuring distributed tracing,
feature-gated deployments, and granular versioned routes."
date: 2025-12-31T23:03:30-04:00
draft: false
tags: ["Rust", "AAProp", "programming", "project", "bioinformatics"]

# Featured image
# Place an image named `featured.jpg/png` in this page's folder and customize its options here.
image:
  caption: "Photo by [Ayush Kumar ](https://unsplash.com/@spexypants) on [Unsplash](https://unsplash.com/photos/a-picture-of-a-structure-that-looks-like-a-structure-qjJvPFepEIM)"
      
cover:
  image: "https://images.unsplash.com/photo-1707135719544-fd75c0e66151?q=80&w=2050"
  position:
    x: 50
    y: 40
  overlay:
    enabled: true
    type: "gradient"
    opacity: 0.4
    gradient: "bottom"
  fade:
    enabled: true
    height: "80px"
  icon:
    name: ""

authors:
  - me

content_meta:
  trending: true
---

## Introduction

This is the second post in the series about AAProp, a RESTful server I developed to distribute information
about Amino Acids.

* [The AAProp Project: Part 1](/blog/aaprop-part1/)
* [The AAProp Project: Part 2](/blog/aaprop-part2/)
* [The AAProp Project: Part 3](/blog/aaprop-part3/)

In the previous post, I discussed why I chose Rust and Axum to build this lightweight read-only API. I further discussed
how I chose to use the [Shuttle](https://shuttle.dev) platform. Now, I will dive
into the actual implementation. What began as a single-file prototype grew into what I consider to be properly
structured library-plus-binary crate, complete with distributed tracing, feature-gated deployment targets, and
versioned API routes. Let's walk through the seven distinct phases of this architectural evolution.

## Phase 1: The Monolithic Beginning

When I first started, the project was a monolithic prototype where everything lived in a single file. The routing,
data lookup, and server bootstrap logic were all side by side. Data was embedded inline, handlers returned raw values,
and adding a new endpoint meant scrolling past entirely unrelated concerns. It worked well enough for a prototype, but
as the project naturally grew, refactoring became inevitable.

This phase can be seen in [commit 7e7d7a8](https://github.com/AliSajid/aaprop/commit/7e7d7a8). The entire project
consists of two parts:

* `src/amino_acid_data.json`, which contains the information I want to serve, and
* `src/lib.rs`, which builds the basic, functional API server.

This is simple, but it works.

## Phase 2: Module Separation

Now that I had the API running, it was time to expand and restructure.
The first major structural change was separating the modules. I took this opportunity to import the data from the JSON
format to an internal `struct`. The data then moved to its own dedicated module with associated structs. 
The routing logic was also isolated into a separate `routes` module, which left the entrypoint strictly for bootstrapping the server. 

The amino acid data became a constant array evaluated at compile time:

```rust
// src/aaprop_lib/data.rs
pub const AMINO_ACID_DATA: [AminoAcid; 20] = [
    AminoAcid::new(
        "Alanine", "Ala", "A",
        SideChain::Nonpolar, 89.09,
        &["GCU", "GCC", "GCA", "GCG"],
    ),
    // ... 19 more entries
];
```

This separation meant each concern had its own file, and the entrypoint shrank down to just a few lines of code.

I also took this opportunity to write some helper functions, that could be called when the appropriate endpoint
is called.


```rust
#[must_use]
pub fn find_by_name(name: &str) -> Option<AminoAcid> {
    AMINO_ACID_DATA.iter()
        .find(|aa| aa.get_name() == name)
        .copied()
}
```

## Phase 3: Adding Observability

Being able to see the flow of requests is essential when you are building and deploying an API. Fortunately,
Shuttle offered an open-telemetry compatible observability layer. All I needed was something that could populate
it. The [`tracing`](https://crates.io/crates/tracing) crate, already a part of the [`Tokio`](https://github.com/tokio-rs/tokio)
ecosystem was the obvious choice.

`tracing` made it easy to add information to requests using the `#[instrument]` attribute. This was combined with
structured output emission from within each function at the `INFO` and `DEBUG` levels. 

For example, my shared `match_amino_acid()` helper logs every attempt it makes to find a match:

```rust
#[instrument]
fn match_amino_acid(amino_acid: &str) -> Option<AminoAcid> {
    event!(Level::INFO, "Matching amino acid: {}", &amino_acid);
    find_by_name(amino_acid)
        .or_else(|| find_by_short_name(amino_acid))
        .or_else(|| find_by_abbreviation(amino_acid))
}
```

Adding tracing before the endpoints proliferate is a great way to avoid retrofitting it later.

Admittedly, this is a noisy strategy. However, we were able to suppress it in production
by setting the appropriate `LOG_LEVEL` environment variable.

[Commit `710c0cc`](https://github.com/AliSajid/AAprop/commit/710c0cc) shows the full set of changes
I did for reference.

## Phase 4: Binary / Library Split

Now that we had an API in place that was able to serve requests, and we were able to see if there were any errors,
it was time for a little house cleaning. So far, I had mostly relied on an ad-hoc structure of a library and a binary
crate. That was suboptimal for many reasons, including what if I wanted to expand the library, or use it for some other
project.

I ended up adopting the following structure: 

```bash
src/
├── aaprop/           # binary crate (entrypoint)
│   ├── main.rs
│   └── cli.rs
└── aaprop_lib/       # library crate (business logic)
    ├── lib.rs
    ├── routes.rs
    ├── data.rs
    ├── responses.rs
    └── models/
        ├── amino_acid.rs
        ├── codon_set.rs
        └── side_chain.rs
```

The library then exposed a `create_router()` function, which, in turn, was called by the binary.

```rust
// src/aaprop/main.rs (standalone branch)
let router = aaprop_lib::create_router();
let listener = tokio::net::TcpListener::bind(&bind_addr).await?;
axum::serve(listener, router).await;
```

This also meant that I could do more drastic changes in the API contract without necessarily
changing the binary's code.

[Commit `808aa23`](https://github.com/AliSajid/AAProp/commit/808aa23)

## Phase 5: Model Refactoring

By this point, the API had a sensible structure, but the models themselves were still doing too much. I wanted to
follow one of my original goals for the project: to "overuse `structs`" as zero-cost abstractions. The next step was
therefore to move each model into its own focused module.

[Commit `a849eb4`](https://github.com/AliSajid/AAProp/commit/a849eb4) introduced the new `models/` structure. The
three core types each had a clearly defined responsibility:

* **`AminoAcid`** represents an amino acid using `&'static str` fields, a `SideChain`, an `f64` molecular weight,
and a `CodonSet`. Its getters are all `const fn`, allowing them to participate in compile-time evaluation.
* **`CodonSet`** represents the codons associated with an amino acid. Since six is the biological maximum, I could
avoid a heap-allocated collection and instead store the individual codons as `Option<&'static str>` values. Is this
the best way to handle it? I believe the answer is **No**, but I kept it because it made sense to me and it worked.
* **`SideChain`** is an enum representing the five categories used by the API: `Nonpolar`, `Polar`, `Acidic`, `Basic`,
and `Positive`.

The `CodonSet` implementation is a particularly nice example of where Rust's type system and compile-time evaluation
can work together:

```rust
pub struct CodonSet {
    num_codons: usize,
    first:  Option<&'static str>,
    second: Option<&'static str>,
    // ... up to sixth
}

impl CodonSet {
    pub const fn new(codons: &'static [&'static str]) -> Self { /* ... */ }

    pub const fn get_all(&self) -> [&'static str; 6] { /* ... */ }
}
```

Rather than storing a dynamically sized collection, the constructor unpacks the input slice into six fixed fields at
compile time. It is slightly more elaborate than simply using a `Vec`, but it keeps the representation entirely static
and avoids runtime allocation. This is also an example where deviating from established software engineering principles
allows for a better product.

I also separated the response types from the underlying models. The API uses DTOs whose fields are wrapped in
`Option<T>` and marked with `skip_serializing_if`:

```rust
#[derive(Serialize, Deserialize, Debug)]
pub struct AminoAcidDetailResponse {
    #[serde(skip_serializing_if = "Option::is_none")]
    pub name:             Option<String>,
    pub short_name:       Option<String>,
    pub abbreviation:     Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub side_chain:       Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub molecular_weight: Option<f64>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub codons:           Option<Vec<String>>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub codon_count:      Option<usize>,
}
```

This gave me a useful separation between the internal representation of an amino acid and the representation exposed
through the API. A granular endpoint can populate exactly the field it needs while leaving everything else as None, so
those unused fields disappear entirely from the serialized response.

The refactoring also gave each model its own test suite using `rstest`. `CodonSet` tests cover zero through six codons,
while `AminoAcid` tests its getters and `Display` implementation.

The result is a collection of small, independently testable types rather than one increasingly complicated model.

## Phase 6: Unified binary and Feature Flags

As I had talked before, the project was deployed using [Shuttle](https://shuttle.dev). However I did not want to be
locked in to a single vendor. This was ultimately a small single binary. I wanted the project to be deployable to Shuttle
as well as on its own. Maintaining separate entrypoints for these environments would have been possible, but it would
also mean duplicating the most important part of the application bootstrap. It would also increase maintenance
burden where a single change would mean two separate updates.

Instead, I opted to use the `cfg_block!` macro, and feature flags to produce two binaries from a single codebase.

[Commit 67c2ae7](https://github.com/AliSajid/AAProp/commit/67c2ae7) shows how this "unified" system worked inside
`main.rs`.

```rust
use cfg_block::cfg_block;

cfg_block! {
    if #[cfg(all(feature = "standalone", not(feature = "shuttle")))] {
        // Local server: clap CLI, tokio runtime, TcpListener
        #[tokio::main]
        pub async fn main() {
            /* ... */
        }
    } else {
        // Shuttle cloud deployment
        #[shuttle_runtime::main]
        pub async fn app() -> ShuttleAxum {
            /* ... */
        }
    }
}
```

When the standalone feature is enabled, which is the default, the application runs as a normal local server. It uses
`clap` for command-line arguments, a Tokio runtime, and a `FmtSubscriber` for structured logging.

With the shuttle feature enabled, the same binary becomes a Shuttle-compatible service instead.

Most importantly, neither deployment target contains its own application logic. Both paths ultimately call the same
`aaprop_lib::create_router()` function.

This is the part I particularly liked about the change. The feature flag only determines how the application starts,
not what the application does.

One codebase, two runtimes, and no duplicated routing or business logic.

## Phase 7: API Versioning & Granular Endpoints

With the internal architecture largely settled, I could finally turn my attention back to the API itself.
The final structural change was to introduce explicit API versioning while expanding the number of available
endpoints. While I do not expect the number of Amino Acids to increase, you can never
be too careful about your data needing an update.

[Commit a03de84](https://www.github.com/AliSajid/AAProp/commit/a03de84) moved the API under `/v1 `and expanded it from
the original two endpoints into nine property-specific routes.

The router now looks like this:

```rust
fn create_router_v1() -> Router {
    Router::new()
        .route("/", get(routes::get_root))
        .route("/amino_acid", get(routes::get_root))
        .route("/amino_acid/{amino_acid}", get(routes::get_amino_acid))
        .route("/amino_acid/{amino_acid}/name", get(routes::get_amino_acid_name))
        .route("/amino_acid/{amino_acid}/short_name", get(routes::get_amino_acid_short_name))
        .route("/amino_acid/{amino_acid}/abbreviation", get(routes::get_amino_acid_abbreviation))
        .route("/amino_acid/{amino_acid}/side_chain", get(routes::get_amino_acid_side_chain))
        .route("/amino_acid/{amino_acid}/molecular_weight", get(routes::get_amino_acid_molecular_weight))
        .route("/amino_acid/{amino_acid}/codon", get(routes::get_amino_acid_codons))
        .route("/amino_acid/{amino_acid}/codon_count", get(routes::get_amino_acid_codon_count))
        .route("/health", get(|| async { StatusCode::OK }))
}

pub fn create_router() -> Router {
    Router::new().nest("/v1", create_router_v1())
}
```

The individual property endpoints make use of the response DTOs introduced in the previous phase. A request for
molecular weight, for example, returns an `AminoAcidDetailResponse` with only `molecular_weight` populated. The
remaining optional fields are omitted during serialization.

I also added a `/health` endpoint. There is nothing clever about this endpoint. It is wired to always return a `200 OK`
response. However, it still suffices to show us that the server is up and running and serving requests. 

Finally, I added integration tests using `axum_test::TestServer` and `rstest`. The tests use parameterized cases to
exercise the different routes:

```rust
#[rstest]
#[case::amino_acid("/v1/amino_acid")]
#[case::amino_acid_name("/v1/amino_acid/Alanine")]
// ...
async fn test_create_router_with_version(
    test_server_with_versioning: TestServer,
    #[case] url: &str,
) {
    let response = test_server_with_versioning.get(url).await;
    assert_eq!(response.status_code(), StatusCode::OK);
}
```

This was also a good point to introduce versioning. Adding `/v1` before the API became widely used costs essentially
nothing, while adding it later could require clients to change their URLs.

The granular routes also give clients some flexibility. A consumer that only needs the molecular weight of an amino
acid does not need to retrieve every other property just to get that one value.

## Conclusion

Looking back at these final three phases, the changes were less about adding functionality and more about making the
functionality easier to reason about.

The model refactoring gave individual concepts their own types and tests. Feature flags allowed the same application
to run in both local and cloud environments without duplicating its logic. Finally, API versioning and granular
endpoints gave the public interface room to evolve without forcing clients to consume more data than they need.

Taken together with the first four phases, the project went from a single-file prototype to a small but deliberately
structured Rust service.

The important lesson for me is that architectural discipline does not require getting everything right from the
beginning. The original implementation was intentionally simple. Each subsequent refactoring happened because the
existing structure had started to make the next change harder than it needed to be.

That feels like a much more useful definition of good architecture: not predicting every future requirement, but
making the code easy enough to change when the requirements inevitably arrive.

Stay tuned for [Part 3](/blog/aaprop-part3) to read about my automation and CI/CD journey.
