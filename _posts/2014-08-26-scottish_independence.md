---
layout: post
title: "Scottish independence: what do the polls say?"
categories:
- politics
tags:
- rstats
- rbloggers
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

Living in Edinburgh it's been hard to avoid the build-up to Scotland's referendum on independence. On September 18<sup>th</sup> 2014, less than a month away as I write this, people living in Scotland will go to the polls to answer the question: Should Scotland be an independent country?

Over the last couple of years there's been a good amount of media coverage and &mdash; more interestingly, from my point of view &mdash; repeat polls to gauge opinion by various newspapers and tv stations. This invites an obvious question: how has the mood in Scotland varied over time with respect to a yes/no vote? And can we detect any biases among those publishing polls?

## The data

Anthony Wells (@[anthonyjwells](https://twitter.com/anthonyjwells)) of YouGov has put together [a table](http://ukpollingreport.co.uk/scottish-independence-referendum) of survey results dating back to January 2012. Without too much hassle we can build a messy `data.frame` from this in R via the `XML` package:

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

After a bit of data ["janitor work"](http://www.nytimes.com/2014/08/18/technology/for-big-data-scientists-hurdle-to-insights-is-janitor-work.html), we can visualise the poll trends over time. Given sampling error and other sources of noise, a loess model can pick out the long-term trends.

<a href="{{ site.baseurl }}/img/indyref_trends.png" target="_blank">
<img class="imgfull" src="{{ site.baseurl }}/img/indyref_trends_thumb.png" />
</a>

## Pollster biases

If we accept the above models as a reasonable estimate of the expected poll response at a given time, we can analyse the residuals of actual poll results and look for systematic biases. In theory, with a respectable sample size (all have ~1000) and a reasonably well-stratified sampling method, we might expect polls results to be roughly normally distributed around the expected polls result &mdash; regardless of who comissioned or performed the poll.

Here are the distributions per poll publisher or commisioner, note that these are only for those who commisioned more than a single poll in this dataset, and only those that my regex has been able to pick out.

<a href="{{ site.baseurl }}/img/indyref_YesBiasNewspapers.png" target="_blank">
<img class="imgfull" src="{{ site.baseurl }}/img/indyref_YesBiasNewspapers_thumb.png" />
</a>

The sample sizes here are generally too small to claim they are polling significantly above or below expectation, save for The Sunday Times (significantly more pro-Independence than expected, p = 7 &times; 10<sup>-4</sup>) and [TNS BMRB](http://www.tns-bmrb.co.uk/home), a "think tank" with offices in London and Edinburgh who seem to both perform and publish their own polls (p < 1 &times; 10<sup>-3</sup>).

```r
# dplyr example (featuring messy subset abuse)
group_by(subset(polls, response == "Yes" &
         newspaper %in% ordering[ordering$count > 1,"newspaper"]),
         newspaper) %>%
  summarise(p=wilcox.test(residual, mu=0)$p.value)

Source: local data frame [14 x 2]

#              newspaper            p
# 1             TNS BMRB 0.0009765625
# 2             Ashcroft 0.5000000000
# 3   Scotland on Sunday 0.2500000000
# 4       Mail on Sunday 0.6250000000
# 5                  Sun 0.1250000000
# 6                Times 0.9101562500
# 7                  STV 0.8750000000
# 8           Daily Mail 0.5000000000
# 9         Daily Record 0.0625000000
# 10  Scotsman on Sunday 0.1250000000
# 11        Sunday Times 0.0007324219
# 12 Wings Over Scotland 0.5000000000
# 13         YesScotland 0.5000000000
# 14                 SNP 0.5000000000

```

<a href="{{ site.baseurl }}/img/indyref_YesBiasPollsters.png" target="_blank">
<img class="imgright" src="{{ site.baseurl }}/img/indyref_YesBiasPollsters_tiny.png" />
</a>

Caveats here are that different polls have used different question sets, methods etc. so this isn't evidence for anything underhanded _per se_. We can look at the same thing per pollster, i.e. it seems reasonable to expect that while newspapers and the SNP might have reasons to publish polls in their favour, people conducting the polls should generally be more or less indifferent.

The results again are hampered by a small number of datapoints per pollster, but  the pollster [Panelbase](https://www.panelbase.net/index.aspx) emerges as one providing significantly yes-skewed poll results (p < 6 &times; 10<sup>-6</sup>). Interestingly they may be the only pollster here to have a [rewards system](https://www.panelbase.net/rewards.aspx) inplace. The only other significantly non-zero biased results come again from TNS BMRB, who published most of their own polls in the above graph.

## Conclusion

What do the polls say? Well, the majority of Scots have been against independence for the last couple of years (and beyond), however polls appear to have been more variable in recent months and the outcome of the referendum is expected to be close.

<a href="{{ site.baseurl }}/img/indyref_yesPercent.png" target="_blank">
<img class="imgleft" src="{{ site.baseurl }}/img/indyref_yesPercent_tiny.png" />
</a>

Since we have a (poorly fitting) linear model here we can &mdash; I must stress this is tongue-in-cheek &mdash; extrapolate to referendum day and get a prediction of the referendum result:

<p style="font-size: larger; text-align:center">42.9% Yes</p>
<p style="font-size: smaller; text-align:center;">(99% confidence interval: 40.9 < <i>x</i> < 45.0)</p>

<hr />

<p style="text-align:right; font-size: .85rem;">R code to reproduce this analysis is available on
<a href="https://github.com/blmoore/blogR" target="_blank">Github</a>.</p>
