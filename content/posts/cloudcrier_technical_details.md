---
title: "The Cloud Crier Project: Technical Notes"
date: 2024-07-01T23:21:58-04:00
draft: false
tags: ["Cloud Crier", "AWS", "Serverless", "Python", "AWS Lambda"]
categories: ["Essays", "Projects", "Technical", "Progress Reports"]
author:
  name: "Ali Sajid Imami"
  link: "/about_me/"
  avatar: "/images/aliimami.png"
  email: "hello@aliimami.com"
---

## Introduction

This posts builds onto, and complements the [introduction](/posts/cloudcrier_introduction) to the Cloud Crier project. In this post, I want to discuss and document the technical details of the project. Particularly, I want to lay down the architecture of the project as well as the tools and technologies that I plan to use.

Finally, I also want to list the principles that I hold dear and the ones I mean to follow as this project develops.

## The Architecture

The Cloud Crier application is a serverless application, written in Python 3.12 and hosted on AWS Lambda. The whole application relies on two Lambda functions. The first one is triggered by a schedule, pushing all the locations into a dedicated SQS queue. This then triggers the Lambda function that gets the data. This function polls the respective APIs for the weather data, transforms it into a consistent format and then stores it in a dynamoDB table.

The figure below shows the architecture of the Cloud Crier application:

{{< figure src="/images/CloudCrier-Architecture.png" alt="The architecture of the Cloud Crier application" caption="The architecture of the Cloud Crier application" >}}

Here is a brief description of the tagged events:

1. The cron Event triggers on the dot of every hour. This event triggers the `CloudCrier-PushLocations` Lambda function.
2. The `CloudCrier-PushLocations` Lambda function reads the list of locations from a JSON file and pushes them into the `CloudCrier-WeatherQueue` SQS queue. Each message in the queue is a location that the `CloudCrier-GetWeather` Lambda function will process, along with the Weather API it needs to query.
3. The `CloudCrier-GetWeather` Lambda function is triggered by the `CloudCrier-WeatherQueue`. It reads the message from the queue, queries the respective Weather API, and transforms the data into a consistent format.
4. The `CloudCrier-GetWeather` Lambda function then stores the data in the `CloudCrier-WeatherData` DynamoDB table.
5. Periodically, the `CloudCarrier-WeatherData` table is exported to an S3 bucket for further analysis.

## The Tools and Technologies

The Cloud Crier application is built using the following tools and technologies:

1. [**Python 3.12**](https://python.org): The application is written in Python 3.12, using the `boto3` library to interact with AWS services.
2. [**AWS Lambda**](https://aws.amazon.com/lambda/): The application is hosted on AWS Lambda, a serverless compute service that runs code in response to events.
3. [**AWS SQS**](https://aws.amazon.com/sqs/): The application uses AWS SQS to decouple the `CloudCrier-PushLocations` and `CloudCrier-GetWeather` Lambda functions.
4. [**AWS DynamoDB**](https://aws.amazon.com/dynamodb/): The application uses AWS DynamoDB to store the weather data in a NoSQL database.
5. [**AWS S3**](https://aws.amazon.com/s3/): The application uses AWS S3 to store the periodic exports of the weather data for further analysis.
6. [**AWS Serverless Application Model (SAM)**](https://aws.amazon.com/serverless/sam/): The application is deployed using AWS SAM, a framework for building serverless applications on AWS.

Some of the above I have some familiarity with, while others are either unfamiliar or my previous experiences
with them were not convincing. Particularly, I am a big fan of [Terraform](https://www.terraform.io/) and its open-source counterpart [OpenTofu](https://opentofu.org/). That said, I realized that the terraform-way of deploying lambdas has a lot more friction. Being a first-party tool, I hope, and expect, that AWS SAM will be easier to get up and running.

## Principles

As I work on the Cloud Crier project, I intend to follow the following principles:

1. **Simplicity**: I will try to keep both the architecture and the code of the application as simple as possible.
2. **Automation**: As much as possible, we will use the available tools that can automate stuff. This includes using a GitHub Actions-based CI/CD pipeline, and dependency updates using `Renovate`.
3. **Documentation**: The project will strive to be well-documented. This includes code comments, README files, and blog posts like this one. Additionally, I would like to host a GitHub Pages-based website in the project itself, that would explain the current status of the project as well as the reasoning for the decisions made.
4. **Transparency**: My goal is to transparently document the inception, development and evolution of this project over its lifetime. These blog posts will serve as the progress report for the project.
5. **Open Source**: I consider myself lucky to have grown up in the age of Open Source. My personal successes would not have been possible without the Open Source movement and community. This project, like all my other projects, will be open source. The code will be available on GitHub under a dual Apache-2.0/MIT license.
6. **Open Science**: Not unlike the above principle, growing up in the age of Open Access journals has made it incredibly easy for me to learn new things and push the edges of knowledge. Any and all data collected, as well as processed data and scripts will be available and any publication that comes out of this project will be published in an Open Access journal.

## Conclusion

This blog post serves as a brief overview of the technical details of the Cloud Crier project. I will keep
updating my blog as I progress. The project can always be tracked at my
personal GitHub account in the [Cloud Crier repository](https://github.com/AliSajid/cloudcrier-app).

As always, if you have any questions or suggestions, please let me know in the comments below.

{{< center-quote >}}
So long, and thanks for all the fish.
{{< /center-quote >}}
