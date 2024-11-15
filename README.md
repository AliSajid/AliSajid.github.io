# Ali Imami Blog / Portfolio Website

| Service                                                  | Variant       | Status                                                                                                                                                                    |
| -------------------------------------------------------- | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Website Status                                           |               | ![Website](https://img.shields.io/website?url=https%3A%2F%2Faliimami.com&up_message=Online&down_message=Offline&logo=hugo&label=Website)                                  |
| Mozilla HTTPS Observatory                                |               | ![Mozilla HTTP Observatory Grade](https://img.shields.io/mozilla-observatory/grade-score/aliimami.com?logo=mozilla&label=Observatory)                                     |
| Chromium HSTS Preload                                    |               | ![Chromium HSTS preload](https://img.shields.io/hsts/preload/aliimami.com?logo=google&logoColor=red&label=HSTS%20Preloaded)                                               |
| Security Headers                                         |               | ![Security Headers](https://img.shields.io/security-headers?url=https%3A%2F%2Faliimami.com%2F&logo=snyk&label=Security%20Headers)                                         |
| [Uptime Robot](https://stats.uptimerobot.com/ki7cmPyCwv) | Status        | ![Uptime Robot status](https://img.shields.io/uptimerobot/status/m798028932-a62986d8237832a89e0591a7?up_message=Operational&down_message=Offline&logo=hugo&label=Website) |
| [Uptime Robot](https://stats.uptimerobot.com/ki7cmPyCwv) | 7 Day Uptime  | ![Uptime Robot ratio (7 days)](<https://img.shields.io/uptimerobot/ratio/7/m798028932-a62986d8237832a89e0591a7?logo=hugo&label=Uptime%20(7d)>)                            |
| [Uptime Robot](https://stats.uptimerobot.com/ki7cmPyCwv) | 30 Day Uptime | ![Uptime Robot ratio (30 days)](<https://img.shields.io/uptimerobot/ratio/m798028932-a62986d8237832a89e0591a7?logo=hugo&label=Uptime%20(30d)>)                            |
| [PingPong](https://aliimami.pingpong.host/en/)           | Status        | ![PingPong status](https://img.shields.io/pingpong/status/sp_04218273e4d24ea6b54efd839fa4717f?logo=hugo&label=PingPong)                                                   |
| [PingPong](https://aliimami.pingpong.host/en/)           | 30 Day Uptime | ![PingPong uptime (last 30 days)](https://img.shields.io/pingpong/uptime/sp_04218273e4d24ea6b54efd839fa4717f)                                                             |

This repository hosts the source code for my [aliimami.com](https://www.aliimami.com) website. It serves as the center point for managing the content and handle the deployment of the website.

## Design

This is a [hugo](https://gohugo.io)-based website. I use the [`FixIt` theme](https://github.com/hugo-fixit/FixIt) to manage and style the content. The `FixIt` theme comes from the tradition of similar themes starting with [`LoveIt`](https://github.com/dillonzq/LoveIt), [`KeepIt`](https://github.com/Fastbyte01/KeepIt) and [`LeaveIt`](https://github.com/liuzc/LeaveIt). This is a simpler and more extendible theme that makes it perfect for my use case.

## Structure

Most of the files in the repository are simply not relevant to content managements. The key directories are as follows:

### 1. [`static`](static)

This directory is supposed to contain all files that should be loaded and made a part of the final website render. This makes it ideal for files that do not change, but, somehow either require presence on the remote server or images that just need to be present

### 2. [`content`](content)

This directory is supposed to contain all the content in it. It includes the static pages and dynamic blog posts that will be transformed from Markdown into HTML.

I have opted for the following convention:

1. Each page has its own directory. The name of that directory will be appended to the domain and will link to the page.
2. All blog posts are in a dedicated blog posts directory where each blog post is its own markdown file.

The current structure of the directory looks like this:

#### a. [`about_me`](/about_me/)

This directory contains an `index.md` file that has the page content and one image file that is a part of that page.

#### b. [`posts`](/posts/)

This directory has one post per Markdown file.
