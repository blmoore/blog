---
layout: post
title: Are more expensive motorcycle helmets safer?
categories:
- r
tags:
- rstats
- rbloggers
- ggplot2
- dplyr
- motorcycle
- safety
- price
status: publish
type: post
published: true
meta:
  _publicize_pending: '1'
author:
permalink: motorcycle-helmet-safety-price
---

Apparently an 80s commerical for the helmet manufacturer [Bell](http://www.bellhelmets.com/) bore the slogan:
_"If you've got a $10 head, wear a $10 helmet"_. Nowadays it's a deeply-ingrained
and widely accepted idea among bikers that it's worth
spending a lot of money on your headgear. A top-of-the-line Arai can sell for
almost four figures, particularly if you want a nice
[race rep](http://www.revzilla.com/motorcycle/arai-corsair-v-joey-dunlop-2014-le-helmet)
 design, but what are you getting for your money and, in particular, is it
 any safer than a helmet you pickup for a tenth of that price?

There are various minimum safety standards for bike helmets. The US has
[Snell and DOT](http://www.smf.org/docs/articles/dot), whereas the UK
requires the snappily named
[BS 6658:1985 specification](http://shop.bsigroup.com/ProductDetail/?pid=000000000030140499)
or the European standard, ECE22.05, [apparently equivalent](http://www.whitedogbikes.com/whitedogblog/motorbike-helmet-road-legal-uk/)
to the US DOT. But these are _minimum standards_ that manufacturers must design towards,
as such they don't help differentiating between ratified helmets.

## SHARP ratings

<img class="imgright" src="{{ site.baseurl }}/img/sharp_logo.png" />

In the UK, an impartial government safety scheme has been set up with its own forced acronym
(the Safety Helmet Assessment and Rating Programme, [SHARP](http://sharp.direct.gov.uk/))
to try to scientifically assess how protective helmets are in [simulated crash-like tests](http://sharp.direct.gov.uk/node/33),
designed using real-world data. Take a look at this [neat animation](http://sharp.direct.gov.uk/content/animation)
for more information.

They condense the data from 32 tests over seven replicates into a simple 5-star rating,
with 5 star helmets [said to provide](http://sharp.direct.gov.uk/content/ratings)
"good levels of protection right around the helmet". As of April 2014, their database
contains a total of 328 helmet models, a decent set of results for some further analysis.

## Price ranges per brand

A good starting point is to look at the spread of helmet prices, identifying the premium
brands and the cheapies that have been tested by SHARP.

<a href="{{ site.baseurl }}/img/motorcycle_helmet_brands_pricerange.png" target="_blank">
<img class="imgfull" src="{{ site.baseurl }}/img/motorcycle_helmet_brands_pricerange_thumb.png" />
</a>

We can see why Bell might be keen to push the idea that we all need expensive helmets!

## Helmet types

Helmets in the dataset are spit into two categories: full-face and "system". As
far as I can tell the latter refer to what I would call "flip-front" helmets.
These have a hinged jaw section which you can raise either to use as an open-face helmet or
more commonly so as to pay for your petrol without scaring the cashier.

<img class="imgfull" src="{{ site.baseurl}}/img/motorcycle_helmetkey.png" />

I'm not aware this has been conclusively proven but the general feeling among bikers
seems to be that a flip-front helmet offers less protection than a more rigid full-face.
Does the SHARP data agree?

<a href="{{ site.baseurl }}/img/motorcyle_helmet_type.png" target="_blank">
<img class="imgfull" src="{{ site.baseurl }}/img/motorcyle_helmet_type_thumb.png" />
</a>

There is a greater proportion of top-rated full-face helmets, and the most
common rating for flip-front lids is 3 stars, compared to 4 for full-face. However
full-face helmets dominate the dataset (86% of helmets tested by SHARP), and most brands
will only produce a couple of flip models, save the specialists like
[Schuberth](http://www.schuberth.com/en/businesssegments/motorcycle.html).

## Cost vs. Protection

The main question to be answered with this dataset is: are more expensive helmets
more protective, and if so to what degree?

<a href="{{ site.baseurl }}/img/motorcycle_helmet_overalltrend.png" target="_blank">
<img class="imgfull" src="{{ site.baseurl }}/img/motorcycle_helmet_overalltrend_thumb.png" />
</a>

Overall yes, there's a non-zero linear regression coefficient that suggests each additional
£ spent on a helmet returns 2 &times; 10<sup>-4</sup> SHARP rating points. It's
worth noting that this trend explains a measly 6% of the variance in helmet ratings and,
more interestingly, the y-intercept is a fairly decent 3.1 rating, suggesting there are some
cheap but highly rated helmets in the dataset.

We can break this relationship trend down by manufacturer:

<a href="{{ site.baseurl }}/img/motorcycle_helmet_brandtrends.png" target="_blank">
<img class="imgfull" src="{{ site.baseurl }}/img/motorcycle_helmet_brandtrends_thumb.png" />
</a>

There are some striking differences here. Entry brands like [Nitro](http://www.nitro-helmets.com/)
seem good examples of where a higher outlay is likely to result in significantly better
crash protection. The [Arai](http://www.whyarai.co.uk/) premium brand, however, has little relationship between
price and protection, with most of their range scoring the same 3 out of 5 rating.

You'll notice the points in these graphs have been jittered to prevent them all stacking
at the integer ratings, and give the illusion of a (preferable) continuous rating.
At this point any statisticians reading may criticise the use of linear
regression here (on unjittered values, of course), as the rating system is really an ordinal variable and so would be
better suited to something like an [ordered logit model](https://en.wikipedia.org/wiki/Ordered_logit).
With these caveats in mind I won't overinterpret the above linear models.

## Best and worsts

So to finish, two important questions: what are the best/worst value for money helmets,
and which brands overall output the most protective and reasonably priced lids?

### Best helmets

<!-- html table generated in R 3.1.0 by xtable 1.7-3 package -->
<!-- Tue Jul  1 21:52:15 2014 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> Make </TH> <TH> Model </TH> <TH> Type </TH> <TH> Price (GBP) </TH> <TH> Rating </TH>  </TR>
  <TR> <TD align="right"> 1 </TD> <TD> Duchinni </TD> <TD> D832 </TD> <TD> Full face </TD> <TD align="right"> 59.99 </TD> <TD align="right">   5 </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD> MT </TD> <TD> Revenge </TD> <TD> Full face </TD> <TD align="right"> 64.99 </TD> <TD align="right">   5 </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD> Lazer </TD> <TD> LZ6 </TD> <TD> Full face </TD> <TD align="right"> 70.00 </TD> <TD align="right">   5 </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD> Nitro </TD> <TD> Aikido </TD> <TD> Full face </TD> <TD align="right"> 70.00 </TD> <TD align="right">   5 </TD> </TR>
  <TR> <TD align="right"> 5 </TD> <TD> Caberg </TD> <TD> Trip </TD> <TD> System </TD> <TD align="right"> 90.00 </TD> <TD align="right">   5 </TD> </TR>
  <TR> <TD align="right"> 6 </TD> <TD> Caberg </TD> <TD> V2 407 </TD> <TD> Full face </TD> <TD align="right"> 90.00 </TD> <TD align="right">   5 </TD> </TR>
  <TR> <TD align="right"> 7 </TD> <TD> Marushin </TD> <TD> 777 Samura </TD> <TD> Full face </TD> <TD align="right"> 99.00 </TD> <TD align="right">   5 </TD> </TR>
  <TR> <TD align="right"> 8 </TD> <TD> Marushin </TD> <TD> 777 Tiger </TD> <TD> Full face </TD> <TD align="right"> 99.00 </TD> <TD align="right">   5 </TD> </TR>
  <TR> <TD align="right"> 9 </TD> <TD> Caberg </TD> <TD> V2R </TD> <TD> Full face </TD> <TD align="right"> 110.00 </TD> <TD align="right">   5 </TD> </TR>
  <TR> <TD align="right"> 10 </TD> <TD> Nitro </TD> <TD> N1700VF </TD> <TD> Full face </TD> <TD align="right"> 119.00 </TD> <TD align="right">   5 </TD> </TR>
   </TABLE>


### Worst helmets

<!-- html table generated in R 3.1.0 by xtable 1.7-3 package -->
<!-- Tue Jul  1 21:54:57 2014 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> Make </TH> <TH> Model </TH> <TH> Type </TH> <TH> Price (GBP) </TH> <TH> Rating </TH>  </TR>
  <TR> <TD align="right"> 1 </TD> <TD> Schuberth </TD> <TD> S1 Pro </TD> <TD> Full face </TD> <TD align="right"> 450.00 </TD> <TD align="right">   2 </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD> Schuberth </TD> <TD> R1 </TD> <TD> Full face </TD> <TD align="right"> 320.00 </TD> <TD align="right">   2 </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD> NZI </TD> <TD> Fibrup </TD> <TD> System </TD> <TD align="right"> 256.80 </TD> <TD align="right">   2 </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD> Arai </TD> <TD> Condor </TD> <TD> Full face </TD> <TD align="right"> 240.00 </TD> <TD align="right">   2 </TD> </TR>
  <TR> <TD align="right"> 5 </TD> <TD> Dainese </TD> <TD> Airstream </TD> <TD> Full face </TD> <TD align="right"> 190.00 </TD> <TD align="right">   1 </TD> </TR>
  <TR> <TD align="right"> 6 </TD> <TD> Vemar </TD> <TD> VSREV </TD> <TD> Full face </TD> <TD align="right"> 190.00 </TD> <TD align="right">   2 </TD> </TR>
  <TR> <TD align="right"> 7 </TD> <TD> KBC </TD> <TD> VR2R </TD> <TD> Full face </TD> <TD align="right"> 180.00 </TD> <TD align="right">   2 </TD> </TR>
  <TR> <TD align="right"> 8 </TD> <TD> KBC </TD> <TD> VR4R </TD> <TD> Full face </TD> <TD align="right"> 179.99 </TD> <TD align="right">   2 </TD> </TR>
  <TR> <TD align="right"> 9 </TD> <TD> Harley Davidson </TD> <TD> Laguna II </TD> <TD> Full face </TD> <TD align="right"> 165.00 </TD> <TD align="right">   1 </TD> </TR>
  <TR> <TD align="right"> 10 </TD> <TD> CMS </TD> <TD> GP5F </TD> <TD> Full face </TD> <TD align="right"> 159.00 </TD> <TD align="right">   1 </TD> </TR>
   </TABLE>

### Brand summaries

Here I'm plotting the mean SHARP rating across each brand's tested helmets, against
their median helmet price which were then ranked 1 to 22, with 22 being the most
expensive brand on average.

<a href="{{ site.baseurl }}/img/motorcycle_helmet_brandsummary.png" target="_blank">
<img class="imgfull" src="{{ site.baseurl }}/img/motorcycle_helmet_brandsummary_thumb.png" />
</a>

Grey rectangles indicate both the cheapest third of brands,
and the safest third. Much to my surprise, the only brand falling in the intersection
of these two is Marushin, which is a new brand to me but have been
[noted previously](http://www.visordown.com/product-features/five-safest-motorcycle-helmets-for-under-150/18341-6.html)
for their highly-rated helmets.

I should quickly point out that protection isn't the only reason people splash out on
premium helmets; they can be lighter, more comfortable, quieter and look better &mdash;
plus with that Shoei symbol above your visor no-one will take you for a
"[squid](http://www.urbandictionary.com/define.php?term=Squid)". However the old
Bell advertising slogan seems a bit hollow now, as the crafty consumer can protect their
priceless head with a 5-star rated helmet for as little as 60 GBP (100 USD).

<hr />

<p style="text-align:right; font-size: .85rem;">Full code to reproduce these
plots and analysis will be available on
<a href="https://github.com/blmoore/blogR" target="_blank">Github</a>.</p>
