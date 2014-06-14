---
layout: post
title: Guardian data blog — UK general election analysis in R
categories:
- politics
tags:
- general election
- ggplot2
- guardian data
- R
- rstats
- UK politics
status: publish
type: post
published: true
meta:
  switch_like_status: '1'
  _publicize_pending: '1'
  geo_public: '0'
author:
---
<p>The Guardian newspaper has for a few years been running a <a title="guardian data blog" href="http://www.theguardian.com/data" target="_blank">data blog</a> and has built up a massive repository of (often) well-curated datasets on a huge number of topics. They even have an <a title="list of data sets made available by the guardian" href="http://www.theguardian.com/news/datablog/interactive/2013/jan/14/all-our-datasets-index" target="_blank">indexed list</a> of all data sets they've put together or reused in their articles.</p>
<p>It's a great repository of interesting data for exploratory analysis, and there's a low barrier to entry in terms of getting the data into a useful form. Here's an example using UK election polling data collected over the last thirty years.</p>

<h2>ICM polling data</h2>

<p>The Guardian and <a title="ICM research" href="http://www.icmresearch.com/" target="_blank">ICM research</a> have conducted monthly polls on voting intentions since 1984, usually with a sample size of between 1,000 and 1,500 people. It's not made obvious how these polls are conducted (cold-calling?) but for what it's worth ICM is a member of the <a title="British Polling Council Wikipedia page" href="http://www.britishpollingcouncil.org/" target="_blank">British Polling Council</a>, and so hopefully tries to monitor and correct for things like the "<a title="shy tory factor" href="https://en.wikipedia.org/wiki/Shy_Tory_Factor" target="_blank">Shy Tory Factor</a>"—the observation that Conservative voters supposedly have (or had prior to '92)  a greater tendency to conceal their voting intentions than Labour supporters.</p>

<h2>Preprocessing</h2>

<p>The data is made available from The Guardian as a <code>.csv</code> file via Google spreadsheets <a title="data" href="https://docs.google.com/spreadsheet/ccc?key=0AonYZs4MzlZbcGhOdG0zTG1EWkVPOEY3OXRmOEIwZmc#gid=0" target="_blank">here</a> and requires minimal cleanup, cut the source information from the end of the file and you can open it up in R.</p>

```r
sop <- read.csv("StateOfTheParties.csv", stringsAsFactors=F)
## Data cleanup
sop[,2:5] <- apply(sop[,2:5], 2, function(x) as.numeric(gsub("%", "", x)))
sop[,1] <- as.Date(sop[,1], format="%d-%m-%Y")
colnames(sop)[1] <- "Date"
# correct for some rounding errors leading to 101/99 %
sop$rsum <- apply(sop[,2:5], 1, sum)
table(sop$rsum)
sop[,2:5] <- sop[,2:5] / sop$rsum
```

Then after <code>melt</code>ing the data.frame down (full code at the end of the post), you can get a quick overview with <code>ggplot2</code>.

<a href="http://benjaminlmoore.files.wordpress.com/2014/03/area_plot.png"><img class="size-large wp-image-549" alt="UK general election overview 1984-2014" src="{{ site.baseurl }}/img/area_plot.png" width="500" height="234" /></a>

<h2>Election breakdown</h2>
<p>The area plot is a nice overview but not that useful quantitatively. Given that the dataset includes general election results as well as opinion polling, it's straightforward to split the above plot by this important factor. I also found it useful to convert absolute dates to be relative to the election they precede. R has an object class, <code>difftime</code>, which makes this easy to accomplish and calling <code>as.numeric()</code> on a difftime object converts it to raw number of days (handily accounting for things like leap years).</p>
<p>These processing steps lead to a clearer graph with more obvious stories, such as the gradual and monotonic decline of support for Labour during the Blair years. </p>
<p><a href="http://benjaminlmoore.files.wordpress.com/2014/03/splitbyelection_2.png"><img src="{{ site.baseurl }}/img/splitbyelection_2.png" alt="UK general election data split by election period" width="500" height="382" class="imagewhite /></a></p>
<p><strong>NB</strong> Facet headers show the election year and result of the election with which the (preceding) points are plotted relative to.</p>

<h2>Next election's result</h2>
<p>I originally wanted to look at this data to get a feel for how things are looking before next year's (2015) general election, maybe even running some predictive models (obviously I'm no <a href="http://fivethirtyeight.com/" title="fivethirtyeight" target="_blank">fivethirtyeight.com</a>). </p>
<p>However, graphing the trends of public support for the two main UK parties hints it's unlikely to be a fruitful endeavour at this point, and with the above graphs showing an ominous increasing support for "other" parties (not accidentally coloured <a href="https://www.ukip.org/" title="ukip" target="_blank">purple</a>), it looks like with about 400 days to go the 2015 general election is still all to play for.</p>
<p><a href="http://benjaminlmoore.files.wordpress.com/2014/03/lab_con.png"><img src="{{ site.baseurl }}/img/lab_con.png" alt="lab_con" width="500" height="607" class="imagewhite" /></a></p>
<hr />
<p>https://gist.github.com/blmoore/9631779</p>
