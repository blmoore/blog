---
layout: post
title: Wikipedia is dead, long live the 'pedia
categories:
- wikipedia
tags:
- analysis
- en.wiki
- R
- Wikipedia
status: publish
type: post
published: true
meta:
  _publicize_pending: '1'
author:
permalink: wikipedia-is-dead
---

<p>I was a bit surprised when looking at the Wikipedia pageviews for 2013 (nicely presented <a href="http://reportcard.wmflabs.org/" target="_blank">here</a>). After 5 years of consistent and reasonably stable growth, over 2013 monthly pageviews actually dropped, and to the tune of 2 *billion* views  (10%) from their peak early in the year.</p>

<a href="http://benjaminlmoore.files.wordpress.com/2014/01/pviews.png"><img class="imgfull" alt="pviews" src="{{ site.baseurl }}/img/pviews.png" width="500" height="352" /></a>

This was surprising to me. The problem Wikipedia has attracting new editors has been <a href="http://www.technologyreview.com/featuredstory/520446/the-decline-of-wikipedia/" target="_blank">well-publicised</a>, but it's never had trouble with PageRank or increasing its reach to casual viewers.</p>

<p>Well, it turns out one area seeing consistent and healthy growth is, as you would guess, mobile views, which are showing gains of about 150k pageviews a month on English Wikipedia. This makes up for almost half a billion of those lost over 2013 in the graph above, but still leaves some explaining to do.</p>

<p><a href="http://benjaminlmoore.files.wordpress.com/2014/01/mobile1.png"><img class="imgright" alt="mobile" src="{{ site.baseurl }}/img/mobile1.png" width="500" height="352" /></a></p>

<p>Interestingly, another useful metric of web traffic, unique visitors per month, continues to <a href="http://reportcard.wmflabs.org/" target="_blank">grow considerably</a>. Maybe this reflects how mobile visitors use the site differently, just looking something up (e.g. to settle an argument) and closing their browser as opposed to a few hours going from topic to topic and ending up admiring a <a href="https://en.wikipedia.org/wiki/List_of_Eiffel_Tower_replicas" target="_blank">list of Eiffel tower replicates</a>.</p>

<img class="imgright" alt="mvvu" src="{{ site.baseurl }}/img/mvvu.png" width="360" height="254" />

<p>A quick graph of mean monthly pageviews per visitor gives this theory some support, but the data seems pretty noisy and has varied a lot over the past few years.</p>

<p>Another possibility is that this data is telling us what we already know: the unique visitors with the highest total page views must be the article writers and the <a href="https://en.wikipedia.org/wiki/Wikipedia:WikiGnome" target="_blank">Wikignomes</a> that built the place — and they've been in precipitous decline for nearly <a href="https://en.wikipedia.org/wiki/File:Wikipedia_editor_numbers.svg" target="_blank">6 years now</a>. I'm speculating of course, but maybe that's starting to show through on the page views site-wide, emphasising how much work a small group of people have been putting in, and the dent they're leaving in Wikipedia as they leave.</p>
<hr />

<p style="text-align: right; font-size: .85rem;">Full R code to reproduce the graphs shown in this post is in a <a href="https://gist.github.com/blmoore/8343067" target="_blank">gist</a>. <br />
This post was originally published on my
<a href="http://benjaminlmoore.wordpress.com/2014/01/09/wikipedia-is-dead-long-live-the-pedia/" target="_blank">Wordpress blog</a>.</p>
<p></p>
