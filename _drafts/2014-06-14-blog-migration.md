---
layout: post
title: Transformation of wordpress into jekyll
categories:
- meta
tags:
- blog
- jekyll
- wordpress
status: publish
type: post
published: true
meta:
  _publicize_pending: '1'
author:
---

I think Wordpress is a great CMS and I'm reluctant to leave it behind. While
it doesn't have much hacker kudos, in my opinion (and undoubtedly many others)
Wordpress has a decent system and doesn't seem to be missing much as a blogging
platform to warrant reinventing the wheel. It also seems to have reached
a kind of critical mass where it's own "like" and "follow" features are
useful tools, with the latter a decent way of building an audience that
don't use RSS readers and aren't interested in most of extra cruft you get
when following a blogger on twitter. In fact, my wordpress blog currently has
more followers than my twitter account, and I suspect a higher CTR per
post. So with that in mind, why am I leaving?

In short, it's due to two factors:

1. The [Github pages](https://pages.github.com/) system offering free hosting
built on top of a github repo.

2. The [rCharts](http://rcharts.io) R package which, to me as a non-web guy,
has acted as a great intro to various [D3.js](http://d3js.org/)-based plotting
libraries, and piqued my interest in building custom interactive graphics.

My setup was getting increasingly complicated, usually with a full write-up
on Wordpress &mdash; to take advantage of the existing audience there &mdash; with accompanying interactive plots hosted here. The problem with this is that the javascript plots were usually the most interesting part of the post, but were buried in external links due to Wordpress limitations. Plus this uneccessarily split would divide social shares and search traffic (not that I'm attempting any SEO or real monetisation but it's nice if people occasionally read my stuff).

I'm now using [Jekyll](http://jekyllrb.com/) (aided by  [poole](https://github.com/poole/poole) during setup). I'm surprsied by how barebones the framework really is, given the buzz I've heard about it and  the various competitors and derivatives for the past couple of years.
