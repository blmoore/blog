---
layout: post
title: Author inflation in academic literature
categories:
- academia
tags:
- academia
- author&nbsp;inflation
- ggplot2
- PLOS
- R
- rplos
- rstats
- rbloggers
status: publish
type: post
published: true
meta:
  switch_like_status: '1'
  _publicize_pending: '1'
author:
permalink: author-inflation
---

<p>There seems to be a general consensus that author lists in academic articles are growing. Wikipedia <a href="https://en.wikipedia.org/wiki/Academic_authorship#Growing_number_of_authors_per_paper" target="_blank">says so</a>, and I've also come across a <a href="http://onlinelibrary.wiley.com/doi/10.1002/asi.21438/abstract" target="_blank">published letter</a> and short <a href="http://www.nature.com/nature/history/full/nature06243.html" target="_blank">Nature article</a> which accept this is the case and discuss ways of mitigating the issue. Recently there was an interesting discussion on <a href="http://academia.stackexchange.com/questions/16759/is-there-an-inflation-in-the-number-of-authors-per-paper" target="_blank">academia.stackexchange</a> on the subject but again without much quantification. Luckily given the array of literature database APIs and language bindings available, it should be pretty easy to investigate with some statistical analysis in R.</p>

<h2>rplos</h2>

<p><a title="ropensci" href="http://ropensci.org/" target="_blank">ROpenSci</a> offers nice R language bindings for the PLOS (I'm more used to PLoS but I'll go with it) API, called <a title="rplos" href="https://github.com/ropensci/rplos" target="_blank">rplos</a>. There's no particular reason to limit the search to PLOS journals but rplos seems significantly more straightforward to work with than pubmed API packages I've used in the past like <a title="RISmed" href="http://cran.r-project.org/web/packages/RISmed/index.html" target="_blank">RISmed</a>.</p>
<p>Additionally the PLOS group contains two journals of particular interest to me:</p>
<ul>
<li><a title="plos comp biol" href="http://www.ploscompbiol.org/" target="_blank">PLOS Computational Biology</a> — a respectable specialist journal in my field; have bioinformatics articles been particularly susceptible to author inflation?</li>
<li><a title="PLOS ONE" href="http://www.plosone.org/" target="_blank">PLOS ONE</a> — the original mega-journal. I wonder if the huge number of articles published here show different trends in authorship over time.</li>
</ul>
<p>The only strange part of the search was at the PLOS API end. To search by the <code>publication_year</code> field you need to supply both a beginning and end date range, in the form:</p>

```r
publication_date:[2001-01-01T00:00:00Z TO 2013-12-31T23:59:59Z]
```

<p>A tad verbose, right? I can't imagine wanting to search for things published at a particular time of day. A full PLOS API query using the rplos package looks something like this:</p>

```r
searchplos(
  # Query: publication date in 2012
  q  = 'publication_date:[2012-01-01T00:00:00Z TO 2012-12-31T23:59:59Z]',
  # Fields to return: id (doi) and author list
  fl = "id,author",
  # Filter: only actual articles in journal PLOS ONE
  fq = list("doc_type:full",
            "cross_published_journal_key:PLoSONE"),
  # 500 results (max 1000 per query)
  start=0, limit=500, sleep=6)
```

<p>A downside of using the PLOS API is that the set of journals are quite recent, PLOS ONE started in 2006 and PLOS Biology was only a few years before in 2003, so it'll only give us a limited window into any long-term trends.</p>
<h2>Distribution of author counts</h2>
<p>Before looking at inflation we can compare the distribution of author counts per paper between the journals:</p>
<p><a href="http://benjaminlmoore.files.wordpress.com/2014/04/beans_overall.png"><img class="imgfull" src="{{ site.baseurl }}/img/beans_overall.png" alt="Distribution of author counts" width="500" height="500" /></a>
<a href="http://benjaminlmoore.files.wordpress.com/2014/04/journal_ecdf.png"><img class="imgright" src="{{ site.baseurl }}/img/journal_ecdf.png" alt="ECDF per journal" width="300" height="300" /></a></p>

<p>Possibly more usefully — but less pretty — the same data be plotted as empirical cumulative distribution functions (ECDF). From these we can see that PLOS Biology had the highest proportion of single-author papers in my sample (n = ~22,500 articles overall) followed by PLOS Medicine, with PLOS Genetics showing more high-author papers at the long-tail of the distribution, including the paper with the most authors in the sample (<a title="couch" href="http://www.plosgenetics.org/article/info%3Adoi%2F10.1371%2Fjournal.pgen.1003212" target="_blank">Couch et al., 2013</a> with 270 authors).</p>

<h2>Author inflation</h2>
<p>So, in these 6 different journals published by PLOS, how has the mean number of authors per paper varied across the past 7 years?</p>
<p><a href="http://benjaminlmoore.files.wordpress.com/2014/04/alltrends.png"><img class="imgfull" src="{{ site.baseurl }}/img/alltrends.png" alt="PLOS author inflation" width="500" height="500" /></a></p>
<p>Above I've shown yearly means plus their 95% confidence intervals, as estimated by a non-parametric bootstrap method implemented in <a title="ggplot2" href="http://ggplot2.org/" target="_blank">ggplot2</a>. Generally from this graph it does look like there's a slight upward trend on average, though arguably the mean is not the best summary statistic to use for this data, which I've shown is not normally distributed, and may better fit an extreme value distribution.</p>
<p>The relationship between publication date and number of authors per paper become clearer if it's broken down by journal:</p>

<p><a href="http://benjaminlmoore.files.wordpress.com/2014/04/plot_lm.png"><img class="imgfull" src="{{ site.baseurl }}/img/plot_lm.png" alt="Author inflation regression" width="500" height="352" /></a></p>

<p>Here linear regression reveals a significant positive coefficient for year against mean author count per paper, as high as .52 extra authors per year on average, down to just .06 a year for PLOS ONE. Surprisingly the mega-journal which published around 80,000 papers over this time period seems least susceptible to author inflation.</p>
<p><a href="http://benjaminlmoore.files.wordpress.com/2014/04/authinflation_bars.png"><img class="imgleft" src="{{ site.baseurl }}/img/authinflation_bars.png" alt="Author inflation per journal" width="214" height="300" /></a>The explained variance in mean number of authors per paper (per year) ranges from .28 (PLOS ONE) up to an impressive .87 for PLOS Medicine, with PLOS Computational Biology not far behind on .83. However, PLOS Computational Biology had the second lowest regression coefficient, and the lowest average number of authors of the six journals — maybe us introverted computer types should be collaborating more widely!</p>

<h2>Journal effects</h2>
<p>It's interesting to speculate on what drives the observed differences in author inflation between journals. A possible covariate is the roundly-condemned "Impact Factor" journal-level metric — are "high impact" journals seeing more author creep than lesser publications?</p>
<p><a href="http://benjaminlmoore.files.wordpress.com/2014/04/corr_authif.png"><img class="imgfull" src="{{ site.baseurl }}/img/corr_authif.png" alt="Correlation of author inflation and impact factor" width="300" height="300" /></a></p>
<p>If estimate of author inflation is plotted against respective journals' recent impact factors, there does indeed appear to be a positive correlation. However, this comparison only has 6 data points so there's not enough evidence to reject the null hypothesis that there is no relationship between these two variables (p = 0.18).</p>

<h2>Conclusion</h2>
<h4>Is author inflation occurring?</h4>
<p><strong>Yes</strong>, it certainly appears to be on average.</p>
<h4>Is it a problem?</h4>
<p>I don't know, but I'd lean towards probably not.</p>
<p>The average trends could be reflecting the proliferation of "<a title="big science" href="https://en.wikipedia.org/wiki/Big_Science" target="_blank">Big Science</a>" with huge collaborative consortiums like <a title="ENCODE" href="http://encodeproject.org/ENCODE/" target="_blank">ENCODE</a> and <a title="FANTOM" href="http://fantom.gsc.riken.jp/" target="_blank">FANTOM</a> (though the main papers of those examples were targeted to <em>Nature</em>) and doesn't necessarily support a conclusion that Publish or Perish culture is forcing lots of token authorships and backhanders between scientists.</p>
<p>Maybe instead (as the <a href="http://academia.stackexchange.com/questions/16759/is-there-an-inflation-in-the-number-of-authors-per-paper" target="_blank">original discussion</a> hypothesised), people that traditionally may not have been credited with authorship (bioinformaticians doing end-point analysis and lab technicians) are now getting recognised for their input more often, or conceivably advances in cloud computing, distributed data storage and video conferencing has better enabled larger collaborations between scientists across the globe!</p>
<p>Either way, evidence for author inflation is not evidence of a problem <em>per se</em> :)</p>

<h3>Caveats</h3>
<ul>
<li>Means used for regression — while we get a surprisingly high R<sup>2</sup> for regression the mean number of authors per paper per year, the predictive power for individual papers unsurprisingly vanishes (R<sup>2</sup> plummets to between .02 and 4.6 × 10<sup>-4</sup> per journal — significant non-zero coefficients remain). Author inflation wouldn't be expected to exhibit consistent and pervasive effects in all papers, for example reviews, letters and opinion pieces presumably have consistently lower author counts than research articles and not all science can work in a collaborative, multi-author framework.</li>
<li>Search limits — rplos returns a maximum of 1000 results at a time (but they can be returned sequentially using the <code>start</code> and <code>limit</code> parameters). They seem to be drawn in reverse order of time so the results here probably aren't fully representative of the year in some cases. This has also meant my sample is unevenly split between journals: PLoSBiology: 2487; PLoSCompBiol: 3403; PLoSGenetics: 4013; PLoSMedicine: 2094; PLoSONE: 7176; PLoSPathogens:3647; <strong>Total:</strong> 22,460.</li>
<li>Resolution — this could be done in a more fine-grained way, say with monthly bins. As mentioned above, for high-volume journals like PLOS ONE, the sample is likely coming from the end of the years from ~2010 onwards.</li>
</ul>
<hr />
<p style="text-align:right;">The full code to reproduce this analysis is <a href="https://gist.github.com/blmoore/9998523" target="_blank">here</a>.<br />
This post was originally published on my
<a href="http://benjaminlmoore.wordpress.com/2014/04/06/author-inflation-in-academic-literature/" target="_blank">Wordpress blog</a>.
</p>
