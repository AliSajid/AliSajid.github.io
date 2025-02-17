---
title: "Year in Code: 2024"
date: 2025-02-16T21:30:16-05:00
draft: false
tags: []
categories: []
bibFile: "static/bibliography.json"
author:
  name: "Ali Sajid Imami"
  link: "/about_me/"
  avatar: "/images/aliimami.png"
  email: "<hello@aliimami.com>"
---

## Introduction

(Not so) Recently, I had a chance to use the extremely slick [Year in Code](https://year-in-code.com)
to visualize my code productivity over the course of 2024. That was a fun ride
and a trip of its own.

I know that we are in the middle of February right now, but I thought it would
still be a good idea to showcase this here and reflect on what it means.

## The Application

[Year In Code](https://year-in-code.com) is a small application from the makers of
[Graphite](https://graphite.dev), that extracts data from your public GitHub
profile, crunches the numbers and turns that into a slick video and a summary graphic
of your activity across the year. This is a really cool use of the available technologies
and honestly, a big boost for us.

Coding day-in, day-out, we lose track of the bigger things that we achieve as we
keep focusing on implementing the next feature or fixing the next thing. It also
provides us a way to reflect on how far we have come.

## My Year in Code

{{< image src="./year-in-review-2024.png" alt="This is alt text" caption="2024 Year in Code report for Ali Sajid Imami" >}}

Here is the graphic that the app generated for me.
I am going to link the video [here](https://year-in-code.com/user/AliSajid)
which is public and anyone can see it as well.

### Overall Impression

I really love the _dark mode_ visualization. The planet earth, with 2024
overlaid on it just looks cute. There's little wasted space and whatever information
is there is displayed judiciously.

### Productivity

Starting with the number of commits, I am honestly surprised. $2399$ contributions
is __A LOT__. Even if you were to pull out just the number of commits ($1837$)
it still averages out to about $5.02$ commits __A DAY__. I did not think that
I had that kind of productivity in 2024.

<!-- vale write-good.ThereIs = NO -->
I am pretty proud of the number of pull requests and reviews I completed.
There is a noticeable increase in the number of PRs. The reason for this is
that even though I mostly work solo, I have decided to embrace [GitHub Flow](https://docs.github.com/en/get-started/using-github/github-flow).
This means that I make heavy use of PRs and PR Reviews.
<!-- vale write-good.ThereIs = YES -->

I have, more recently, started playing with the [_Stacking PR_](https://www.stacking.dev/) workflow, particularly
using [Graphite](https://graphite.dev) and found that to be useful in certain circumstances. Can't say I am
fully comfortable with that, but I am optimistic. The _Stacking PR_ workflow also results
in an increase in the number of PRs, something I don't mind.

### Highest Productivity

The graphic includes three high productivity markers that are in the report:

1. _March_ was the most productive month, with 328 contributions.

    As I try to remember, I can't recall a specific reason why that might be the
    case. However, that was clearly a good time for me to be coding. Averaging
    more than one contribution a day is pretty good.

1. _Thursday_ was the most productive day of the week, with 436 contributions.

    This, at least, makes a little more sense. Thursdays were historically seminar
    days. This usually allowed me to have more time to focus on work. There were
    also fewer meetings on Thursdays for me. I definitely like the average of $8.36$
    contributions for each Thursday.

1. The _One Day_ with the highest number of contributions was March 14th, with
65 contributions.

    I am not sure what happened that day, but it must have been a good day.

### Top Languages

The top languages for 2024 for me were, in order:

1. Rust
1. TypeScript
1. R
1. HTML
1. Lua


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

__Lua__ is also an easy one. This year, I was aggressively migrating to [neovim](https://neovim.io/)
as my Text Editor/IDE of choice. Since neovim config files are mostly written in
Lua, it ended up on the list.

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
