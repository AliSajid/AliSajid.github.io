---
title: "The Galaxy Platform: Bioinformatics for the Masses"
date: 2024-03-23T13:23:14-04:00
draft: false
tags: ["Galaxy", "Bioinformatics", "Gratitude", "Technical"]
categories: ["Bioinformatics", "Galaxy", "Technical"]
author:
  name: "Ali Sajid Imami"
  link: "/about_me/"
  avatar: "/images/aliimami.png"
  email: "hello@aliimami.com"
---

## Introduction

If there is one thing Bioinformatics scientists are good at, it's tool development. Of particular note are the scientists of the Computers Science and Biostatistics persuasion. This would be a great thing, if it were not for the fact that we are notoriously militant about our work styles, tool design and language choice. On top of this, we have the issue of the already fragmented state of the language ecosystems, particularly the two most popular languages in Bioinformatics: Python and R.

The end result of all of this is we have an abundance of tools but not many consistent workflows where multiple tools work together without intermediate representations or gentle massaging of the data. This, then, makes it particularly difficult to generate a system where you have multiple tools installed, let alone multiple versions of tools, isolated from each other.

## A Bioinformatics Solution for Non-Bioinformaticists

It is within this context that Galaxy was born. Galaxy is the brain-child of James Taylor, one of the early pioneers of Bioinformatics. He created Galaxy as a way to make Bioinformatics accessible to people who are not Bioinformaticists. The idea was to create a web-based platform where you could upload your data, run your analysis and download your results without having to worry about installing tools, dependencies, or even knowing how to use the command line. An additional advantage here, was the ability to record the exact tool and version used to generate the output, making the entire analysis virtually reproducible.

## The Circle of Life

This brings us back to present day. Today, it has become increasingly important to keep track of the tools, versions, exact steps taken, and the exact parameters set for each tool, to ensure that the result remains intelligible, interpretable, and most importantly reproducible. This has then attracted the attention of Bioinformaticists, like myself, who are in the business of building reproducible pipelines, and testing new tools as they come out.

## The Galaxy Servers

Fortunately, there are four major public Galaxy servers that are available for use by the public. These are:

1. [Galaxy Main](https://usegalaxy.org)
2. [Galaxy Europe](https://usegalaxy.eu)
3. [Galaxy Australia](https://usegalaxy.org.au)
4. [Galaxy France](https://usegalaxy.fr)

These servers are free to use, and you can upload your data, run your analysis and download your results. The only caveat is that you have to be mindful of the data you upload, as these servers are shared by many people, and you do not want to accidentally expose sensitive data to the public. Because of their public nature, these systems also impose certain restrictions on the amount of data that you can store. These values are pretty generous[^1], but if you are working with really large datasets, and doing it with some regularity, you might want to consider setting up your own Galaxy server. That's, right, the entire Galaxy setup, the software and the infrastructure design is open source and available for you to use. You can find the source code for the Galaxy platform [here](https://github.com/galaxyproject/galaxy) and instructions to set it up [here](https://galaxyproject.org/admin/get-galaxy/).

However, that, admittedly, is a niche use case. Maybe you are the [National Institutes of Health](https://www.nih.gov) or the [European Bioinformatics Institute](https://www.ebi.ac.uk) and you have a lot of data and a lot of users (and a lot of money). Or you are one of the few institutes that house local infrastructure capable of handling all this computation and data. For most of us, however, we only occasionally need to go above the limits given. For those cases, Galaxy people have been kind enough to provide us with a [Google Form](https://docs.google.com/forms/d/e/1FAIpQLSf9w2MOS6KOlu9XdhRSDqWnCDkzoVBqHJ3zH_My4p8D8ZgkIQ/viewform) to request a temporary Quota Increase.

## The Use Case

I am currently working in the [Cognitive Disorders Research Lab](https://cdrl-ut.org) at the University Of Toledo. As I pursue my PhD in Bioinformatics, I have found myself in the role of the lead maintainer of tools and tool lists, and the chief executor of _What If?_ experiments. For most of our computational needs, we either rely on the [Ohio Supercomputer Center's](https://www.osc.edu) clusters or custom solutions we build on [Amazon Web Services](https://aws.amazon.com). However, both of those platforms conform to rather rigid access policies, the latter ones both designed and enforced by us. This makes them a little less than ideal for ad-hoc, _let's throw everything at the wall and see what sticks_ sort of experiments.

Recently, an individual reached out to us, with their whole genome sequencing data, asking us if we could identify mutations in their genome that may have predisposed them to their particular illness. They had their genome sequenced and found that they carried a particular mutation from a commercial entity and wanted to double-check. Since the original analysis was done in the **Dark Ages**[^2], I decided that we should use newer tools, and the latest (and my favorite[^3]) human genome assembly - CHM13. Given that the most powerful machine I own is a laptop, that I travel with constantly, I could not run the analysis on my machine. So, I turned to Galaxy.

The first pass at the analysis took a little over 36 hours, before I realized that I had set some parameters wrong. This, then, gave me the idea of running the analysis with some slightly varying parameters and a couple different variant discovery tools. This led to me quickly running into the storage limit.

Following this, I freaked out a little. Then I did what any Bioinformaticists worth their salt would do: Googled it! This led to the discovery of the aforementioned Google Form. I filled it out, and within 24 hours, I had my storage limit increased to 500 GB. For a month! This was more than enough for me to finish my analysis, and I was able to download the results and share them with the individual.

## Conclusion

Galaxy is a great platform for people who are not Bioinformaticists, but need to do some Bioinformatics. It is also a great platform for Bioinformaticists who need to do some Bioinformatics analyses, but don't have the resources to do it on their own machines. The public servers are great for most use cases, but if you need more resources, you can always request a temporary increase in your storage limit.

{{< center-quote >}}
So long, and thanks for all the fish.
{{< /center-quote >}}

[^1]: I have personally used both the [Galaxy Main](https://usegalaxy.org) and [Galaxy Europe](https://usegalaxy.eu) servers which give you 250 GB and 500 GB of storage respectively.

[^2]: Given the velocity of advances in Bioinformatics, anything older than 3 years should be considered ancient. That does not stop people from USING THE HG19 ASSEMBLY IN 2023! But we can still shame them for it.

[^3]: Being a bioinformaticist entitles you to quite a few things, including, but not limited to your favorite Human Genome Assembly ([CHM13](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_009914755.1/)), your favorite RNASeq Dataset ([GSE80655](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE80655)) and your favorite aligner ([HiSat2](https://daehwankimlab.github.io/hisat2/)).
