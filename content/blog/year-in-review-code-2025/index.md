---
title: "Year in Code: 2025"
summary: "Reflection on the GitHub activity in 2025"
date: 2026-03-03T21:30:16-05:00
draft: false
tags: ["Reflection", "Essay", "Programming", "Year-in-code", "GitHub"]

# Featured image
# Place an image named `featured.jpg/png` in this page's folder and customize its options here.
image:
  caption: "GitHub Year in Code Review for 2025 from [year-in-code.com](https://year-in-code.com)"

      
cover:
  image: "cover.jpg"
  position:
    x: 3
    y: 0.1
  overlay:
    enabled: true
    type: "gradient"
    opacity: 0.6
    gradient: "bottom"
  fade:
    enabled: true
    height: "80px"
  icon:
    name: "brands/github"

authors:
  - me

content_meta:
  trending: true
---

## Introduction

As the tradition dictates, I am back with another Year in Code Review. This is
a sequel to my post [from last year](../year-in-review-code-2024/). I did use
the same [Year in Code](https://year-in-code.com) review tool for 2025, just for
the sake of consistency.

This was a fun ride, nonetheless, and I could see some familiar and some new
insights emerging from this.

## My Year in Code

{{< figure src="year-in-review-2025.png" alt="2025 Year in Code report for Ali Sajid Imami" caption="2025 Year in Code report for Ali Sajid Imami" >}}

Here is the graphic that the app generated for me.
I am going to link the video [here](https://year-in-code.com/user/AliSajid)
which is public and anyone can see it as well.

### Overall Impression

Overall, that's a lot of big numbers. I am both impressed and slighlty concerned
about my computer use here.

### Productivity

This year, I have $1265$ total commits. This is a decrease from last year's $2399$
but honestly, not by a lot. The daily commit rate comes out to be $3.47$ commits
per day.

However, Even the total number of contributions is $1982$ and that's a large
number. The number of PRs is reasonable as well, because of Github Flow.

### Highest Productivity

The graphic includes three high productivity markers that are in the report:

1. _January_ was the most productive month, with 348 contributions.

    As I try to remember, I can't recall a specific reason why that might be the
    case. However, that was clearly a good time for me to be coding. Averaging
    more than one contribution a day is pretty good.

1. _Friday_ was the most productive day of the week, with 7.9 contributions per day.

    For this year, Friday makes sense. That marked the end of the week and often
    meant I had more time to work.

1. The _One Day_ with the highest number of contributions was January 3rd, with
141 contributions.

    I am not sure what happened that day, but it must have been a good day.

### Top Languages

The top languages for 2024 for me were, in order:

1. TypeScript
1. Rust
1. R
1. Shell
1. Javascript


This list is not surprising, but some explanation as to why the languages are
where they are is in order.

Let's start with the obvious one: __R__. As you may or may not know, I am a
Bioinformaticist, who works with what is effectively Biological Data Science.
For this domain, R is the _lingua franca_. So much so that there is a huge repository
of Bioinformatics Software called [BioConductor](https://bioconductor.org) which
hosts R packages. Thus, it is not surprising that it showed up on the list.
It would have been a surprise if it hadn't. The only thing I wondered was why
it hadn't been higher up on the list, but the list of [top repositories](#top-repositories)
cleared that up for me.

__TypeScript__ and __HTML__ can be lumped together in one category: Web Apps.
In 2024, I experimented a lot with the [Svelte](https://svelte.dev) and [SvelteKit](https://svelte.dev/docs/kit/introduction)
to write small but non-toy web applications. The results were mostly mixed, but the
learning was real. However, you can't escape TypeScript or HTML if you are building
Web Apps. Those are the rules. One non Web App example for heavy TypeScript use
though is the [`random-wait-action`](https://github.com/AliSajid/random-wait-action)
GitHub Action. This is a small but non-trivial action that I made for myself,
but it definitely is being used by other people.

Finally, let's talk about the crab in the room: __Rust__. I have been learning
Rust for over three years now and have had quite a lot of fun on this journey.
While, I am no Rust expert, I am definitely an advanced beginner. The power that
Rust has lent me has allowed me to build some tools that I would not have been able
to build with the higher-level or dynamic languages. The leading project, of course,
is [`aaprop`](https://github.com/AliSajid/aaprop) which is a RESTful API to
provide information about Amino Acids. Other projects include a [BrainF*ck Interpreter and Visualizer](https://github.com/AliSajid/brainfoamkit),
a [Prisoner's Dilemma Simulator](https://github.com/AliSajid/dilemma-tactix)
and a [Digital Implementation of the MENACE AI for Tic-Tac-Toe](https://github.com/AliSajid/tictacrustle).

### Top Repositories

And now, it's time for the projects that got the most love over 2024.

These are:

1. [aaprop](https://github.com/AliSajid/aaprop)
1. [drugfindR](https://github.com/CogDisResLab/drugfindR)

    and
1. [random-wait-action](https://github.com/AliSajid/random-wait-action)


#### AAProp

AAProp, or Amino Acid Properties server is a really important for me. It is also
one of the projects that I consider _complete_ in the sense that there really isn't
much left to add.

At its core, it's a small Rust based RESTful API Server that provides you with
information about the 20 naturally occurring amino acids. This information includes
their names and codes, the codons that code for it, their side chains and their
molecular weights.

However, if you look deeper, it will show you deeply complex project that tries
to implement best practices in security, automated CI/CD and availabilities of binaries
for multiple platform. This project is my template for any major CLI project that I
might undertake in the future as almost everything that is not it's code, is
battle tested.


#### drugfindR

It will be fair to say that drugfindR is my baby. It's an R package that I developed
from scratch, to interface with the iLINCS database and allow scientists to quickly
and efficiently screen transcriptional profiles against drug signatures. This is
a piece of scientific software, but I have always strived to ensure it is supported
and remains of the highest quality.

It is currently under consideration at BioConductor and I expect it will be
accepted soon.

#### random-wait-action

Have you ever used GitHub Actions to interact with some kind of API and hit
rate limiting? I have. Which is why I created this GitHub Action to inject
a random but configurable amount of delay between steps where you might face
rate limiting.

This was just for my own use, but I developed it in a way that mirrored a full
GitHub Action. Funnily enough, when I looked for its uses, I found out that
it is [definitely being used by people that are not me.](https://github.com/search?q=AliSajid%2Frandom-wait-action+path%3A.github%2Fworkflows%2F+language%3AYAML&type=Code&s=indexed&o=desc)


## Conclusion

It has been a wild year. Here's to another one!


{{< center-quote >}}
So long, and thanks for all the fish.
{{< /center-quote >}}
