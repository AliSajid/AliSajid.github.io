---
title: "The Cloud Crier Project: Introduction"
date: 2024-06-29T20:15:16-04:00
draft: false
tags: ["Cloud Crier", "AWS", "Serverless", "Python", "AWS Lambda"]
categories: ["Essays", "Projects", "Technical", "Progress Reports"]
---

## Introduction

Today, I would like to introduce all of you to a project that I have been thinking about
for a long time now[1]. This project has been living rent-free in my head for
more than a decade at this point and really want to get it out of my head and
into being.

## The Background

When I was a little kid, we had exactly one TV channel in our country. That one
channel was the state-owned broadcaster called [Pakistan Television (PTV)](https://en.wikipedia.org/wiki/Pakistan_Television_Corporation). This channel, not unlike the British Broadcasting Corporation (BBC), had to wear a lot of hats. It provided us with news, entertainment, educational content and even
post-watershed content[2].

Being the nerd that I was, my two favorite TV _spots_ were the weather forecast
in the morning, just before I left for school and the tracking of the Pakistan Stock
Exchange (PSX) at the end of the 9 o'clock news. Again, being the nerd that I was,
I would note these things down in a school notebook. I did not have the internet,
the mathematical training or other tools that would allow me to do anything with
this data, but it was still fun to track.

I was always fascinated by the weather forecasts, and puzzled by the jokes that
surround the profession. I mean, they could not possibly that wrong all the time.
Otherwise, they would be very quickly out of a job. Right?

## The Question

This brings me to the question I've had since:
{{< center-quote >}}
**Can we quantify the accuracy of weather predictions?**
{{< /center-quote >}}

As I found out through the years that the meteorologists can predict the weather
at various levels of accuracy over an increasing number of days. This led to me
asking the next question:
{{< center-quote >}}
**Can we quantify the accuracy of weather predictions, based on how far out they are?**
{{< /center-quote >}}

All of this really leads me to formulate the following hypothesis:
{{< center-quote >}}
**It is possible to quantify the accuracy of weather predictions, based on the variables of weather, time of day, and how far the prediction is from the _now_.**

{{< /center-quote >}}

## The Project

This brings me to the current project: `Cloud Crier`. The name is helpful suggestion
from [llama3](https://llama.meta.com/llama3/), for which I'm grateful. In this
project, I aim to collect weather data on a regular basis and then analyze it
once I have enough data to build a model of the accuracy of weather predictions.

The `Cloud Crier` project has two parts:

1. Data Collection
2. Data Analysis

### Data Collection

#### Data Sources

I am going to use two different sources of data for this project:

1. The [OpenWeatherMap API](https://openweathermap.org/api).
2. The NOAA[3]/NWS[4] Weather API available at [weather.gov](https://www.weather.gov/documentation/services-web-api).

Both of these services provide the current weather, as well as hourly forecasts. That said,
each service has one important advantage that forces me to use both:

1. The OpenWeatherMap's OneCall API provides the weather forecast for the next 48 hours in 1-hour intervals. However, it has can provide me with that data for any location in the world.
2. The NOAA/NWS API provides the weather forecast for the next 7 days in 1-hour intervals. However, it only provides data for the United States.

Since I am interested in looking at the accuracy of weather predictions in both
high income and low income countries, I would like to use both. This will allow
me to poll data for multiple countries and multiple locations in the US using the
OpenWeatherMap API and the NOAA/NWS API.

#### Locations and Variables

For the first phase of the project, I will be collecting the data from the following
locations:

- Islamabad, Pakistan
- Lahore, Pakistan
- Multan, Pakistan
- Toledo, Ohio, USA
- Newark, New Jersey, USA
- Palo Alto, California, USA
- London, United Kingdom
- Singapore, Singapore

I am particularly interested in the following variables:

- Temperature
- Humidity
- Wind Speed
- Wind Direction
- Sky Cover
- Precipitation

#### Data Retrieval, Storage and Processing

The data collection part of the project will be implemented as a small serverless
application running on [AWS Lambda](https://aws.amazon.com/lambda/). This application
will be responsible for collecting the data and transforming it into a format
that is more amenable to analysis.

I intend to store the data in a [DynamoDB](https://aws.amazon.com/dynamodb/) table,
with periodic exports to [S3](https://aws.amazon.com/s3/) for backup and analysis.

Keep in mind that this is both a high-level overview and a work in progress. I intend to
document my progress in this project and share my lessons learned as I go along.

### Data Analysis

So, we have the data from 8 cities in the world, twice for three of them. Now What?

{{< figure src="/images/8vfok0.jpg" title="Analyse All The Data" alt="Meme template of an excited drawn character with the text 'Analyze all the data' superimposed.">}}

For now, the picture above would have to stand in for the data analysis step. I
have not yet decided what tools I would use for the analysis, beyond simple
descriptive statistics and visualizations, implemented in [R](https://www.r-project.org/).

## Conclusion

Today, I have introduced a project that I've wanted to do for a long time and now intend
to develop in public, as it goes. I hope this will be educational and entertaining,
and failing that, just entertaining. The project can always be tracked at my
personal GitHub account in the [Cloud Crier repository](https://github.com/AliSajid/cloudcrier-app).

Anything that I have missed or that you would like to know more about, please let me
know in the comments below.

{{< center-quote >}}
So long, and thanks for all the fish.
{{< /center-quote >}}

[1]: I first had that idea in the summer of 2012 and have worked on various
iterations and implementations, off and on, since then. Never came close to
a _deployable_ state though.

[2]: The post-watershed content here is in the context of mid-nineties Pakistan.
Make of that what you will.

[3]: National Oceanic and Atmospheric Administration

[4]: National Weather Service
