---
layout: post
title: Scottish independence&#58; what do the polls say?
categories:
- politics
tags:
- rstats
- ggplot2
- dplyr
- indyref
- scotland
- polls
status: publish
type: post
published: true
permalink: scottish-independence-polls
---

Living in Edinburgh it's been hard to avoid the build-up to Scotland's referendum on independence. On September 8<sup>th</sup> 2014, less than a month away as I write this, people living in Scotland will go to the polls to answer the question: Should Scotland be an independent country?

Over the last couple of years there's been a good amount of media coverage and &mdash; more interestingly, from my point of view &mdash; repeat polls to gauge opinion by various newspapers and tv stations. This invites an obvious question: how has the mood in Scotland varied over time with respect to a yes/no vote? Can we detect any biases among those publishing polls.

## The data

Anthony Wells ([@anthonyjwells](https://twitter.com/anthonyjwells)) of YouGov has put together [a table](http://ukpollingreport.co.uk/scottish-independence-referendum) of survey results dating back to January 2012. Without too much hassle we can build a messy `data.frame` from this in R via the `XML` package:

```r
polls <- readHTMLTable("http://ukpollingreport.co.uk/scottish-independence-referendum", skip.rows=1)[[1]]
colnames(polls) <- c("pollster", "date", "yes", "no",
                     "non-voting", "dontknow", "yessplit")
polls
#                                   pollster     date yes no ...
# 1                     Survation/Daily Mail 07/08/14  37 50 ...
# 2                           YouGov/Sun (3) 07/08/14  35 55 ...
# 3                                 TNS-BMRB 07/08/14  32 45 ...  
# 4                       Ipsos MORI/STV (1) 03/08/14  40 54 ...
# 5                 Survation/Mail on Sunday 01/08/14  40 46 ...
```

## Polls over time

After a bit of data ["janitor work"](http://www.nytimes.com/2014/08/18/technology/for-big-data-scientists-hurdle-to-insights-is-janitor-work.html), we can visualise the poll trends over time. Given sampling error and other sources of noise (though I think these sample sizes tend to be decent), a loess model can pick out the long-term terms.

<a href="{{ site.baseurl }}/img/indyref_trends.png" target="_blank">
<img class="imgfull" src="{{ site.baseurl }}/img/indyref_trends_thumb.png" />
</a>

## Pollster biases

If we accept the above models as a reasonable estimate of the expected poll response at a given time, we can analyse the residuals of actual poll results and look for systematic biases. In theory, with a respectable sample size and a reasonably well-stratified sampling method, we might expect polls results to be roughly normally distributed around the expected polls result.
