---
layout: post
title: Transformation of wordpress into jekyll
categories:
- meta
tags:
- blog
- jekyll
- wordpress
- slidify
- ruby
- github&nbsp;pages
status: publish
type: post
published: true
meta:
  _publicize_pending: '1'
author:
---

I think [Wordpress](http://wordpress.org/) is a great [CMS](https://en.wikipedia.org/wiki/Content_management_system) and I'm reluctant to leave it behind. While
it doesn't have much hacker kudos, in my opinion (and undoubtedly many others)
Wordpress is a very usable and near-complete blogging
platform which doesn't leave much justification for reinventing the wheel. It also seems to have reached
a kind of critical mass where it's own "like" and "follow" features are
useful tools, with the latter a decent way of building an audience that
don't use RSS readers and aren't interested in the extra cruft that comes with twitter. In fact, my Wordpress blog currently has
more followers than my twitter account, and I suspect a higher [CTR](https://en.wikipedia.org/wiki/Click-through_rate) per
post. So with that in mind, why am I making the switch?

In short, it's due to two factors:

1. The [Github pages](https://pages.github.com/) system offering free hosting
with custom domains, all built on top of a normal git repo.

2. The [rCharts](http://rcharts.io) R package which, to me as a non-web guy,
has acted as a great intro to various [D3.js](http://d3js.org/)-based plotting
libraries, and piqued my interest in building custom interactive graphics.

My blog setup was getting increasingly messy, usually with a full write-up
on [hosted wordpress](https://wordpress.com/) &mdash; to take advantage of the existing audience there &mdash; with accompanying interactive plots hosted here. The problem with this is that the javascript plots were usually the most interesting part of the post, but were buried in external links due to wordpress limitations. Plus this split would divide social shares and search traffic (not that I'm attempting any SEO or real monetisation but it's nice if people occasionally read my stuff).

<img src="{{ site.baseurl }}/img/jekyll.png" class="imgright" width="200px" height="110px" />
After researching my options, I'm now using [Jekyll](http://jekyllrb.com/) (aided by [poole](https://github.com/poole/poole) during setup). With Github pages hosting, Github will run Jekyll on their servers, building your site when you push commits, but they do so with the <code>--safe</code> flag, disabling any plugins not found in the main Jekyll repository. For this reason I now have a [staging repo](https://github.com/blmoore/blog-staging) where I'll (via a simple bash script) build the site locally with whatever custom plug-ins, then copy it to my Github [userpage repository](https://github.com/blmoore/blmoore.github.io) and publish.

Other than this issue it's been reasonably straightforward to make the switch, though I was surprised how much legwork was involved in things like organising [tag-specific paginated indexes](http://realjenius.com/2012/12/01/jekyll-category-tag-paging-feeds/) for navigation and custom RSS/Atom feeds. For me, this kind of stuff should come out of the box even in a barebones, for-customisation framework like Jekyll. Thankfully there's bloggers around who've already figured out this stuff, as well as some of the under-documented features (like [permalinks](http://joshualande.com/short-urls-jekyll/)).

More recently I've been told that the R package [slidify](http://blm.io/blog/slidify) is capable of Jekyll-like functionality, and this will soon be spun-off into its own package:

<blockquote class="twitter-tweet" data-conversation="none" lang="en"><p><a href="https://twitter.com/benjaminlmoore">@benjaminlmoore</a> Slidify is also capable of generating static blogs. It will become a separate package <a href="http://t.co/ED09PAhGyW">http://t.co/ED09PAhGyW</a> <a href="https://twitter.com/rmflight">@rmflight</a></p>&mdash; Ramnath Vaidyanathan (@ramnath_vaidya) <a href="https://twitter.com/ramnath_vaidya/statuses/479422134968524801">June 19, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Most of my posts will involve some R analysis so this could end up a better solution for me, as a non-Rubyist. Maybe I'll be having another big change in a few months time...
