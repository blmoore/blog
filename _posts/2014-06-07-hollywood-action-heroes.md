---
layout: post
title: Hollywood action heroes
categories:
- movies
tags:
- dataviz
- movies
- dimplejs
- ggplot2
- R
- rcharts
- rstats
- rbloggers
status: publish
type: post
published: true
permalink: action-heroes
---

<div style="float:right;width: 20%">
<img src="{{ site.baseurl }}/img/arnie10.jpg" width=80% style="border:2px solid #cccccc; display:block; margin-right: auto; margin-left: auto;"/>
<figcaption>
<p style="font-size:smaller">Arnie 2010 (<a href="https://commons.wikimedia.org/wiki/File:SchwarzeneggerJan2010.jpg" target="_blank">source</a>)</p>
</figcaption>
</div>
<p>
I recently read <a href="http://www.amazon.com/gp/product/1451662440/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=1451662440&linkCode=as2&tag=blmio-20&linkId=H7MGQFNQ3X6N6UJK">Arnie's autobiography</a>
(great fun) and in it he writes about the various roles he's
had, discussing those movies that flopped or were surprise box office successes,
but it's hard to build up an overall picture of his career from these fragments.
Similarly the raw filmography lists at <a href="http://www.imdb.com/name/nm0000216/?ref_=nv_sr_1" target="_blank">IMDb</a>
and <a href="https://en.wikipedia.org/wiki/Arnold_Schwarzenegger#Filmography" target="_blank">Wikipedia</a>
are pretty uninspiring.
</p>
<p>
That gave me the idea of charting his movie career over time, attempting to
show a lot of information at once about how well the film did at box office
relative to its budget, and at what points these successes and failures
happened over the last few decades. After some
<a href="http://imdbpy.sourceforge.net/" target="_blank">python-powered</a>
scraping of IMDb data, this is what I came up with:
</p>

<a href="{{ site.baseurl }}/img/arnie.png"><img src="{{ site.baseurl }}/img/arnie_thumb.png" width=100% /></a>
<p>
It's interesting to see the trajectory from back-to-back hits in low
budget action films (Terminator, Predator, Commando) to a peak of a $200 million
budget for <a href="https://en.wikipedia.org/wiki/Terminator_3:_Rise_of_the_Machines" target="_blank">Terminator 3</a>
(considerably more in 2014 dollars, after adjusting for
inflation). Of course you can then see his stretch as Governor of California
from 2003-11, punctuated only by a <a href="https://www.youtube.com/watch?v=hrMmiUSVRRI" target="_blank">memorable cameo</a>
in The Expendables <sup>(and an excluded minor role in The Kid & I)</sup>.
</p>
<p>
The eagle-eyed will notice some films are missing, there's no
<a href="http://www.imdb.com/title/tt0065832/" target="_blank">Hercules in New York</a>
and others of his earliest films. This is down to IMDb's budget and gross listings
being woefully incomplete, but thankfully most of his famous lead roles are shown.
</p>
<p>
These next obvious step was to look at other actors that fill a similar
niche; how does Sly Stallone compare? What about the more recent action
stars?
</p>

<div class="gallery">

<figure class="gallery-item">
<a href="{{ site.baseurl }}/img/sly.png" target="_blank">
<img src="{{ site.baseurl }}/img/sly_thumb.png">
<figcaption class="img-title">
<h5>Sylvester Stallone</h5>
</figcaption>
</a>
</figure>

<figure class="gallery-item">
<a href="{{ site.baseurl }}/img/bruce.png" target="_blank">
<img src="{{ site.baseurl }}/img/bruce_thumb.png">
<figcaption class="img-title">
<h5>Bruce Willis</h5>
</figcaption>  </a>
</figure>

<br clear="all" />

<figure class="gallery-item">
<a href="{{ site.baseurl }}/img/li.png" target="_blank">
<img src="{{ site.baseurl }}/img/li_thumb.png">
<figcaption class="img-title">
<h5>Jet Li</h5>
</figcaption>
</a>
</figure>

<figure class="gallery-item">
<a href="{{ site.baseurl }}/img/chan.png" target="_blank">
<img src="{{ site.baseurl }}/img/chan_thumb.png">
<figcaption class="img-title">
<h5>Jackie Chan</h5>
</figcaption>
</a>
</figure>

<br clear="all" />

<figure class="gallery-item">
<a href="{{ site.baseurl }}/img/statham.png" target="_blank">
<img src="{{ site.baseurl }}/img/statham_thumb.png">
<figcaption class="img-title">
<h5>Jason Statham</h5>
</figcaption>
</a>
</figure>

<figure class="gallery-item">
<a href="{{ site.baseurl }}/img/vin.png" target="_blank">
<img src="{{ site.baseurl }}/img/vin_thumb.png">
<figcaption class="img-title">
<h5>Vin Diesel</h5>
</figcaption>
</a>
</figure>

<br clear="all" />

<figure class="gallery-item">
<a href="{{ site.baseurl }}/img/seagal.png" target="_blank">
<img src="{{ site.baseurl }}/img/seagal_thumb.png">
<figcaption class="img-title">
<h5>Steven Seagal</h5>
</figcaption>
</a>
</figure>


<figure class="gallery-item">
<a href="{{ site.baseurl }}/img/rock.png" target="_blank">
<img src="{{ site.baseurl }}/img/rock_thumb.png">
<figcaption class="img-title">
<h5>Dwayne Johnson</h5>
</figcaption>
</a>
</figure>

</div>


<a href="{{ site.baseurl }}/img/clint.png" target="_blank">
<img src="{{ site.baseurl }}/img/clint_bigthumb.png" width=100%>
</a>
<p>
So we've learnt that <a href="http://www.imdb.com/name/nm0000246" target="_blank">Bruce Willis</a>
is in way too many films to label clearly, and Jackie Chan doesn't seem to mind frenetically
jumping from big-money blockbusters and low-budget action flicks.
</p>
<p>
<div style="float:right;width: 50%">
<img src="{{ site.baseurl }}/img/roi.png" width=95% style="border:2px solid #cccccc; display:block; margin-right: auto; margin-left: auto;" />
<figcaption>
<p style="font-size:smaller">Fancy a gamble? Pick Sly or Jackie as your lead.</p>
</figcaption>
</div>

I can use this data to look at the mean expected return on investment (ROI)
per leading man, by just taking the mean gross over budget. This shows that
<a href="http://www.imdb.com/name/nm0000329/" target="_blank">Jackie Chan</a>,
albeit with a pretty huge amount of variance, has the highest expected ROI of the actors
listed here. At the other end of the scale is
<a href="http://www.imdb.com/name/nm0005458/" target="_blank">Jason Statham</a>, but in fairness I haven't
normalised for the budgets of the films they're starring in &mdash; if you stick to
$100 million films it's pretty much impossible to then multiple that by ten at the box office!
</p>

<h3>All-time totals per actor</h3>
<p>
Another (possibly fairer) way to compare these guys is by total budgets
and grosses over their careers. It's <a href="http://www.imdb.com/help/show_leaf?infosource" target="_blank">not entirely clear</a>
where IMDb gets these values from, so the absolute numbers should be taken with a pinch of salt.</p><br />
<div id='actionBudget' class="rChart"></div>
<script src="{{ site.baseurl }}/js/action_budget.js"></script>

<p>Here's the same graph but by box office takings. These numbers from IMDb are even <em>more</em>
suspect and vary according to different sources. Additionally, to convert the gross
to 2014 dollars I used a <a href="https://en.wikipedia.org/wiki/Consumer_price_index" target="_blank">measure of inflation</a>
from the year the film was released in &mdash; to
calculate this more accurately you need a breakdown of the gross over time. Unlike lists at
<a href="http://www.boxofficemojo.com/" target="_blank">Box Office Mojo</a>, these charts do
sometimes contain cameo roles (e.g. Bruce and Arnie get Expendables I credits), and as I mentioned
with Arnie, there's unfortunately some missing or incomplete data on IMDb which has lead to some
films being excluded.
</p><br />
<div id='actionGross' class="rChart"></div>
<script src="{{ site.baseurl }}/js/action_gross.js"></script>

<p>
It turns out Sly has grossed more than Arnie on smaller budgets! We can also see
Jackie Chan punches well above his weight in terms of absolute earnings, as well as ROI.</p>

<p>Finally here's budget plotted against gross for most of the individual films used in this analysis.</p>
<div id='actionBudgetVGross' class="rChart"></div>
<script src="{{ site.baseurl }}/js/action_budgetVgross.js"></script>

<p>The python and R scripts to recreate all the above analysis are
<a href="https://github.com/blmoore/blogR" target="_blank">on github</a>,
and it should be pretty straightforward to extend this over any other actors
or actresses you might be interested in (like, say, Jean-Claude Van Damme whom
  I completely forgot about).
  </p>
