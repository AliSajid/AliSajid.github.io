---
title: "The AAProp Project: Part 1"
subtitle: "Genesis"
date: 2024-12-31T23:03:27-04:00
draft: false
tags: ["Rust", "AAprop", "Programming", "Project", "Bioinformatics"]
categories: ["Rust", "AAProp", "Programming", "Bioinformatics"]
author:
    name: "Ali Sajid Imami"
    link: "/about_me/"
    avatar: "/images/aliimami.png"
    email: "<hello@aliimami.com>"

---

## Introduction

<!-- Write the introduction here -->
I have lately been enamored by the [Rust Programming Language](https://www.rust-lang.org/). I have never really had
a good experience with C or C++ enough for me to build actual projects in the language. I respect them
because they have made the majority of our modern infrastructure, but I personally had a lot of trouble getting
into those languages. This is where Rust won me over with the cleaner syntax, promises of memory safety
and the excellent teaching community built around it. One of the most important thing that made me
want to actively build projects in Rust was NoBoilerplate/Tris's [YouTube video](https://www.youtube.com/watch?v=Z3xPIYHKSoI) about how Rust makes it easier
for you to "Finish the projects".

As a chronic procrastinator and programmer, I have left a trail of unfinished and half finished projects in my wake.
My perfectionism and the fact that I am now an academic has not helped this, since we stereotypically never go past 80%.
However, it does seem that the promise that Tris made to me actually holds, and I am happy to introduce the [AAProp Project](https://github.com/AliSajid/aaprop)
to you.

## The AAprop Project

More than once in my bioinformatics research, I have felt the need to copy over a few files that contain generally static
data into a new project. That's just the nature of the job. There's a lot of data that is either static[^1], settled[^2],
stated[^3] or slow-changing[^4]. Some of this data is available for us through the Big Government Websites$^{tm}$, and I am grateful
for that. This allows us to have a single source of truth that remains the same throughout the world. However, note that I said "A Lot",
and not "All". This is important.

For the data that is available, accessing these
websites and databases can be a little tedious or long-winded. For example, the NCBI[^5] has an API that can be accessed over the internet.
However, the catch here is that you have to use the rather long-winded entrez utilities interface which is based on SOAP. They are working on a RESTful
interface, but in the meantime we have to stick with parsing XML.

The result is that in the two cases where:

- The effort to obtain this information will outweigh its utility OR
- The information is not available AT ALL,

You are on your own. The <kbd>Ctrl+C</kbd> / <kbd>Ctrl+V</kbd> solution starts looking really attractive at this point.


One thing that I had to do QUITE A LOT was looking up the information for the twenty or so amino acids that are
part of proteins. This is excluding any sort of modification or the more exotic amino acids. Since the information about
these amino acids is settled[^2], and the whole set is tiny, I thought it was a project worthy of building its own
RESTful Read-only API server.

### The Scope

The scope of this project is pretty simple.

Have a simple web server that:

- Has most of the relevant information about the twenty amino acids
- Allows me to look them up with any of the identifiers that I know (Full name, three-letter code, single letter code)
- Allows me to target specific information and retrieve only that
- Returns the information in JSON format

For the greater scope of the project, I had these requirements:

- It should be as automated as possible, from building to deployment
- It should also be served off an HTTPS backend
- It should cost me as little as possible (read "Free")

## The Design Decisions

Based on the above requirements, I started looking into the services and frameworks that will allow me to do that.

This was broken down into two very different but related parts:

1. Selecting a Rust Framework to build the application
2. Selecting a service for deployment

### Selecting the Rust Framework

Rust has quite a few different frameworks for building RESTful APIs.

In broad strokes the choices boil down to:

- [Actix](https://actix.rs/)
- [Axum](https://github.com/tokio-rs/axum)
- [Rocket](https://rocket.rs/)

While I was researching it, I read a lot of blog posts and ended up settling on [Axum](https://github.com/tokio-rs/axum).
There really was no particular reason except I liked the approach for how to design and write applications. No offense was intended to the
other frameworks.

### Selecting a Hosting Provider

<!-- vale proselint.Cliches = NO -->
<!-- vale write-good.Cliches = NO -->
For hosting, we are really spoiled for choices. Here are the options I came up with
off the top of my head:
<!-- vale write-good.Cliches = YES -->
<!-- vale proselint.Cliches = YES -->

- [Amazon Web Services with ECS](https://aws.amazon.com/ecs/)
- [Google Cloud Run](https://cloud.google.com/run)
- [Fly.io](https://fly.io)

However, I had recently come across the service called [Shuttle](https://shuttle.rs). This service was free,
tuned for Rust and was integrated directly into `cargo`. This made it the top choice for me.

## Implementation Decisions

Now came the part about the actual implementation. For this, I decided to use the following principles:

1. Overuse `structs`. After all, they are [Zero Cost Abstractions](https://without.boats/blog/zero-cost-abstractions/).
2. Embed the Amino Acid data in the binary itself. This is a very small amount of data, and embedding it is perfect for a Read-Only system like this.
3. Ensure that the information can be accessed by any identifier.

## Conclusion

<!-- Write the conclusion here -->
So there we have the first part of my journey. In [the second part](/posts/aaprop-part2/) I will go over the actual implementation
of the project and the things I learned. I will end this with the [third and final post](/posts/aaprop-part3/) which deals with CI, automation
and deployment.

{{< center-quote >}}
So long, and thanks for all the fish.
{{< /center-quote >}}

[^1]: For example things like the molecular weights of Amino Acids
[^2]: For example the names of species and their associated IDs in certain databases
[^3]: For example the BLOSUM62 matrix of similarities
[^4]: For example the reference genome assemblies
[^5]: [The National Center for Biotechnology Information](https://ncbi.nlm.nih.gov)
