---
layout: post
title: "UK general election polls in rCharts and shiny"
categories:
- politics
tags:
- ggplot2
- shiny
- rcharts
- webdev
- R
- rbloggers
status: publish
type: post
published: true
permalink: uk-general-election-rcharts-shiny
---

With under two weeks to go to the 2015 UK general election, there's no better time to take stock of all the voter intention polls being published by the British media. The data has already been aggregated by [UKpollingreport](http://ukpollingreport.co.uk/voting-intention-2)—a site I've used before for [analysis of the Scottish independence referendum](http://blm.io/blog/scottish-independence-polls/)—and there's not much more to be said then is already widely known: it's likely no single party will win an outright majority and we'll be left with a coalition or minority government.

Interactive visualisations, statistical projections and swingometers have already been expertly put together all over the place (among the best I've seen are from [The Guardian](http://www.theguardian.com/politics/ng-interactive/2015/feb/27/guardian-poll-projection) and [FiveThirtyEight](http://fivethirtyeight.com/interactives/uk-general-election-predictions/))—I can't really begin to compete here, but given the data is readily available, I've taken this as a good chance to finally learn shiny and build a simple web application.

## Interactive javascript plot

<style>
div.highcharts-container{
	margin: 0 auto !important;
};
</style>

Before getting to shiny, I started off I started by putting together an interactive (client-side) javascript plot using the [rCharts](http://rcharts.io/) package (specifically the [Highcharts library](http://www.highcharts.com/)).

<div id='ge2015' class="rChart"></div>
<script src="{{ site.baseurl }}/js/ge2015.js"></script>

<br />
This already comes with some neat functionality: as well as tooltips you can drag over an area to zoom in, and you can add or remove series by (de)selecting them from the legend. However any more complicated processing, especially on the raw data, would be better run server-side.

## Shiny

Enter RStudio's [shiny](http://shiny.rstudio.com/), the much-lauded web application framework for R which I'm well-overdue in trying out. Better still, RStudio's [shinyapps](http://www.shinyapps.io/) hosting service is now out of beta and offers a limited free plan for anyone to play about with!

To start out with I redesigned the above plot in <code>ggplot2</code> (you can see the code [on github](https://github.com/blmoore/blogR/blob/master/R/ge2015_polls.R)):

<a href="{{ site.baseurl }}/img/ge2015_ggplot_full.png" target="_blank">
<img class="imgfull" src="{{ site.baseurl }}/img/ge2015_ggplot_thumb.png" />
</a>

Of course, it's possible to use shiny to draw javascript plots but for this example I just wanted to replicate the same kind of functionality—while also extending the shiny version with features that would probably need to be pre-computed in a client-side plot (such as aggregating counts by week and refitting loess models per group).

Next with the help of Rstudio's [shiny tutorials](http://shiny.rstudio.com/tutorial/), it was surprisingly straightforward to add a couple of control widgets and pass their values over to the server-side script which does the heavy lifting (code is again [on github](https://github.com/blmoore/blogR/tree/master/shiny/ge2015)).

<a href="http://blmr.shinyapps.io/ge2015/" target="_blank">
<img class="imgfull" src="{{ site.baseurl }}/img/ge2015_shiny.png" />
</a>

The [end-result](https://blmr.shinyapps.io/ge2015/) is still rudimentary, but has shown me how simple shiny is to get started with—I'm certain I'll be building something more impressive with it in future!

<hr />

<p style="text-align:right; font-size: .85rem;">R code to reproduce these
plots is available on
<a href="https://github.com/blmoore/blogR" target="_blank">Github</a>.</p>
