---
layout: post
title: Meticulously recreating bitmap plots in R
categories:
- R
- Wikipedia
tags:
- ggplot2
- R
- rstats
- Wikipedia
status: publish
type: post
published: true
meta:
  _publicize_pending: '1'
  _wp_old_slug: meticulously-recreating-existing-plots-in-r
author: 
---
<p>There's a hard-fought drive on Wikimedia commons to convert those images that should be in vector format (i.e. graphs, diagrams) from their current bitmap form. At the time of writing, the relevant category has over <a href="https://commons.wikimedia.org/wiki/Category:Images_that_should_use_vector_graphics" target="_blank">7000</a> images in the category "Images that should use vector graphics".</p>
<p>The usual way people move between the two is by tracing over the raster, and great tools like <a href="http://www.inkscape.org/en/" target="_blank">Inkscape</a> (free open-source software) can help a lot with this. But in the case of graphs I thought it'd be fun to try and rebuild a carbon copy from scratch in R.</p>
<h2>The original</h2>
<p>[caption id="attachment_400" align="aligncenter" width="500"]<a href="http://benjaminlmoore.files.wordpress.com/2014/02/original.png"><img class="size-large wp-image-400" alt="This is the original bitmap plot I wanted to recreate." src="img/original.png?w=500" width="500" height="343" /></a> This is the original bitmap plot I wanted to recreate. <em>(Courtesy of <a href="https://commons.wikimedia.org/wiki/File:US_EmpStatsBLS_Jan09-Feb13.png" target="_blank">Wikimedia Commons</a>)</em>[/caption]</p>
<p>The file that first caught my eye was this nice graph of US employment stats, currently used on the highly-trafficked <a href="https://en.wikipedia.org/wiki/Barack_Obama" target="_blank">Obama article</a>. I'm not sure what drew this originally, it doesn't look like Excel because of the broken axis and annotations, but maybe it is. It's currently a png at about 700 × 500 so should be an easy target for improvement.</p>
<h2>Figure 2.0</h2>
<p>The two raw data files are available <a href="http://data.bls.gov/timeseries/LNS14000000" target="_blank">here</a> and <a href="http://data.bls.gov/timeseries/CES0000000001?output_view=net_1mth" target="_blank">here</a> as Excel spreadsheets. They have some weird unnecessary formatting so the various xls parsers for R won't work; save the tables from Excel as csv. I won't talk through the code as it wasn't too taxing (or clean) but it'll be at the end of the post. Here's what I came up with:</p>
<p>[caption id="attachment_427" align="aligncenter" width="500"]<a href="https://upload.wikimedia.org/wikipedia/commons/2/25/US_Employment_Statistics.svg"><img class="size-large wp-image-427 " alt="I realise the irony in having to upload a bitmap version for wordpress, but click for the SVG." src="img/recre_v5.png?w=500" width="500" height="349" /></a> I realise the irony in having to upload a bitmap version for wordpress, but click for the SVG.[/caption]</p>
<p>I expanded my plot to include the 2013 data, so it inescapably has slightly different proportions to the original. And I was working on a single monitor at the time so I didn't have a constant comparison. I can see now a few things are still off, the fonts are different sized for one and I ditched the broken axis, but overall I think it's a decent similarity!</p>
<h2>ggplot2 version</h2>
<p>Two y-axes on the same graph is bad, bad, bad and unsurprisingly forbidden with ggplot2 but I did come across <a href="http://rwiki.sciviews.org/doku.php?id=tips:graphics-ggplot2:aligntwoplots" target="_blank">this</a> method of dummy-facetting and then plotting separate layers per facet. An obvious problem is now the y-axis are representing different things and you only have one label. A hacky fix is to write your ylabs into the facet header (I'm 100% confident Hadley Wickham and Leland Wilkinson would not be impressed with this). Another alternative would be to use map a colour aesthetic to your y-axis values and label it in the legend (again, pretty far from recommended practice).</p>
<p>This is what I ended up with, I still think it's a reasonable alternative to the above, and the loess fitted model nicely shows the unemployment rate trend without the seasonality effects:</p>
<p><a href="http://benjaminlmoore.files.wordpress.com/2014/02/ggplot_bitmap.png"><img class="aligncenter size-large wp-image-413" alt="ggplot_bitmap" src="img/ggplot_bitmap.png?w=500" width="500" height="432" /></a></p>
<h2>Article version</h2>
<p>While mimicking the original exactly was fun (for me at least), I tried to improve upon it for the actual final figure for use on Wikipedia. For instance, it now uses unambiguous month abbreviations, and I swapped the legend for colour-coded text labels. It still has some of the original's charm though. Looks like after a bit of a rough patch, your employment statistics are starting to look pretty good Mr. President.</p>
<p><a href="http://benjaminlmoore.files.wordpress.com/2014/02/new_v2.png"><img class="aligncenter size-large wp-image-431" alt="new_v2" src="img/new_v2.png?w=500" width="500" height="332" /></a></p>
<p>Next up, the other <em>much</em> less attractive figures on that page ([<a href="https://en.wikipedia.org/wiki/File:U.S._Total_Deficits_vs._National_Debt_Increases_2001-2010.png" target="_blank">1</a>], [<a href="https://en.wikipedia.org/wiki/File:PPACA_Premium_Chart.jpg" target="_blank">2</a>]).</p>
<hr />
<p>https://gist.github.com/blmoore/8794075</p>
