---
title: "When we're all driving Rolls-Royce's..."
date: 2024-02-19T12:50:42-05:00
draft: false
tags: [R, Programming, Code-Review, Optimization]
categories: [Programming, R]
---

Recently, in a meeting with our collaborators, I was asked to provide my _professional opinion_ on some code that they had shared with us.
I had reviewed that code already and my first impression of it was that it was a bit inefficient and confusing. At that point, I could have gone into the details of who the code was inefficient in parts, or how it had variables with non-descriptive names, or how it was not very well commented. However, that's when something clicked for me.

All of those problems do not really matter when it comes to the end-user. The problems I was seeing with the code were all problems with the _shape_ of the code, not the _function_ of the code. The code did what it was supposed to do, and it did it well. It was not the most efficient code, but it was not inefficient either. It was not the most readable code, but it was not unreadable either. It was not the most commented code, but it was not uncommented either.

With that realization, I took a moment to consider the _why_ of the code in question. What it was trying to do was obviously brilliant. It was quite clever in how it went about processing the input data that was not always the same shape either. That was what I said in that meeting. I praised the code for its cleverness and for solving the particular domain problem that it was designed to solve. I did say that there may be stylistic problems, but those were mostly personal preferences, and not important in the grand scheme of things.

As programmers, we often get stuck looking at software in a particular manner. To quote a cliché, we often overlook the forest for the trees. Under most circumstances, whether or not the trees are all aligned perfectly does not matter when you are looking at the forest. The forest is what matters. The forest is the _function_ of the code. The trees are the _shape_ of the code. The shape of the code is important, but only in so far as it affects the function of the code. If the shape of the code does not affect the function of the code, then it is not important.

Considering that we were talking about he code that was implemented in `R`, talking about efficiency is not really the biggest problem anyway. `R` is made for solving higher level problems. We should focus on that. Talking about efficiency in `R` is a bit like talking about the fuel efficiency of a Rolls-Royce. It is not the point of the car. The point of the car is to be luxurious and comfortable. The point of `R` is to be a high-level language that is easy to use and understand. It is not meant to be the fastest language, or the most efficient language.

When we are all driving Rolls-Royce's, we should not really worry about fuel efficiency.

{{< center-quote >}}
So long, and thanks for all the fish.
{{< /center-quote >}}
