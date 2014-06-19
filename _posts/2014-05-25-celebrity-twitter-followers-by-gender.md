---
layout: post
title: Celebrity twitter followers by gender
categories:
- twitter
tags:
- dataviz
- demographics
- gender
- ggplot2
- R
- rcharts
- rstats
- twitter
status: publish
type: post
published: true
meta:
  geo_public: '0'
  _wpas_mess: Celebrity twitter followers by gender http://wp.me/p2NHj0-bq
  _publicize_pending: '1'
author:
permalink: twitter-genders
---

<p>The most popular accounts on twitter have millions of followers, but what are their demographics like? Twitter doesn't collect or release this kind of information, and even things like name and location are only voluntarily added to people's profiles. Unlike Google+ and Facebook, twitter has no real name policy, <a href="https://gigaom.com/2011/09/16/why-twitter-doesnt-care-what-your-real-name-is/" target="_blank">they don't care</a> what you call yourself, because they can still divine out useful information from your account activity.</p>
<p>For example, you can optionally set your location on your twitter profile. Should you choose not to, twitter can still just <a title="geolocation" href="https://en.wikipedia.org/wiki/Geolocation" target="_blank">geolocate</a> your IP. If you use an anonymiser or VPN, they could use the timing of your account activity to infer a timezone. This could then be refined to a city or town using the topics you tweet about and the locations of friends and services you mention most.</p>

<p>I chose to look at one small aspect of demographics: gender, and used a cheap heuristic based on stated first name to estimate the male:female ratios in a sample of followers from these very popular accounts.</p>

<h2>Top 100 twitter accounts by followers</h2>
<p>A top 100 list is made available by <a title="Twitter Counter" href="http://twittercounter.com/pages/100" target="_blank">Twitter Counter</a>. It's not clear that they have made this list available through their API, but thanks to the markup, a quick hack is to scrape the usernames using <a title="RCurl" href="http://www.omegahat.org/RCurl/" target="_blank">RCurl</a> and some <a title="Regex" href="https://en.wikipedia.org/wiki/Regular_expression" target="_blank">regex</a>:</p>


```r
require("RCurl")
top.100 <- getURL("http://twittercounter.com/pages/100")
# split into lines
top.100 <- unlist(strsplit(top.100, "\n"))
# Get only those lines with an @
top.100 <- top.100[sapply(top.100, grepl, pattern="@")]
# Grep out anchored usernames: <a ...&gt;@username</a>;
top.100 <- gsub(".*>@(.+)<.*", "\\1", top.100)[2:101]
head(top.100)
# [1] "katyperry"  "justinbieber"  "BarackObama"  ...
```

<h2>R package twitteR</h2>
<p>Getting data from the <a title="twitter API" href="https://dev.twitter.com/" target="_blank">twitter API</a> is made simple by the twitteR package. I made use of <a title="twitteR" href="http://davetang.org/muse/2013/04/06/using-the-r_twitter-package/" target="_blank">Dave Tang's worked example</a> for the initial OAuth setup, once that's complete the twitteR package is really easy to use.</p>
<p>The difficulty getting data from the API, as ever, is to do with <a title="rate limits" href="https://dev.twitter.com/docs/rate-limiting/1.1" target="_blank">rate limits</a>. Twitter allows 15 requests for follower information per 15 minute window. (Number of followers can be queried by a much more generous 180 requests per window.) This means that to get a sample of followers for each of the top 100 twitter accounts, it'll take <em>at a minimum</em> 1 hour 40 mins to stay on the right side of the rate limit. I ended up using 90 second sleep windows between requests to be safe, making a total query time of two and a half hours!</p>
<p>Another issue is possibly to do with strange characters being returned and breaking the JSON import. This error crops up a lot and meant that I had to lower the sample size of followers to avoid including these problem accounts. After some highly unscientific tests, I settled on about 1000 followers per account which seemed a good trade-off between maximising sample size but minimising failure rate.</p>

```r
# Try to sample 3000 followers for a user:
username$getFollowers(n=3000)
# Error in twFromJSON(out) :
#  Error: Malformed response from server, was not JSON.
# The most likely cause of this error is Twitter returning
# a character which can't be properly parsed by R. Generally
# the only remedy is to wait long enough for the offending
# character to disappear from searches.
```

<h2>Gender inference</h2>
<p>Here I used a relatively new R package, <a title="gender package" href="https://github.com/ropensci/gender" target="_blank">rOpenSci's gender</a> (kudos for resisting gendR and the like). This uses U.S. social security data to probabilistically link first names with genders, e.g.:</p>

```r
devtools::install_github("ropensci/gender")
require("gender")
gender("ben")
#   name proportion_male proportion_female gender
# 1  ben          0.9962            0.0038   male
```

<p>So chances are good that I'm male. But the package also returns proportional data based on the frequency of appearances in the SSA database. Naively these can be interpreted as the probability a given name is either male or female. So in terms of converting a list of 1000 first names to genders, there are a few options:</p>
<ol>
<li><strong>Threshold</strong>: if  &gt;.98 male or female, assign gender, else ignore.</li>
<li><strong>Probabilistically</strong>: use random number generation to assign each case, if a name is .95 male and .05 female, on average assign that name to females 5% of the time.</li>
<li><strong>Bayesian-ish</strong>: threshold for almost certain genders (e.g. .99+) and use this as a prior belief of gender ratios when assigning gender to the other followers for a given user. This would probably lower bias when working with heavily skewed accounts.</li>
</ol>
<p>I went with #2 here. Anecdotal evidence suggests it's reasonably accurate anyway, with twitter analytics (using bag of words, sentiment analysis and all sorts of clever tricks to unearth gender) estimating my account has 83% male followers (!), with probabilistic first name assignment estimating 79% (and that's with a smaller sample). Method #3 may correct this further but the implementation tripped me up.</p>

<h2>Results</h2>
<p><a href="http://benjaminlmoore.files.wordpress.com/2014/05/twittergenderdist.png"><img class="imgfull" src="{{ site.baseurl }}/img/twittergenderdist.png" alt="Celebrity twitter followers by gender" width="500" height="833" /></a></p>

<p>So boys prefer football (soccer) and girls prefer One Direction, who knew? Interestingly Barack Obama appears to have a more male following (59%), as does Bill Gates with 67%.</p>

<p>At the other end of the spectrum, below One Direction, Simon Cowell is a hit with predominantly female twitter users (70%), as is Kanye West (67%) and Khloe Kardashian (72%).</p>

<p>Another surprise is that Justin Bieber, famed as teen girl heartthrob, actually has a more broad gender appeal with 41 / 59 male-female split.</p>
<h2>Interactive charts</h2>

<a href="http://blm.io/twitter"><img class="imgright" src="{{ site.baseurl }}/img/screen-shot-2014-05-25-at-11-51-25.png" alt="Click for an interactive version." width="150" height="86" /></a>

<p>Using the fantastic <a title="rcharts" href="http://rcharts.io/" target="_blank">rCharts</a> library, I've put together some <a title="interactive charts" href="http://blm.io/twitter" target="_blank">interactive graphics</a> that let you explore the above results further. These use the <a title="NVD3" href="http://nvd3.org/" target="_blank">NVD3 graphing library</a>, as opposed to my <a href="http://rcharts.io/viewer/?6c9ed5eed37fe3c03fa5" target="_blank">previous effort</a> which used <a href="http://dimplejs.org/" target="_blank">dimple.js</a>.</p>

<p>The first of these is ordered by number of followers, and the second by gender split. The eagle-eyed among you will see that one account from the top 100 is missing from all these charts due to the JSON error I discuss above, thankfully it's a boring one (sorry <a href="https://twitter.com/TwitPic" target="_blank">@TwitPic</a>).</p>

<p>Where would your account be on these graphs? Somehow I end up alongside Wayne Rooney in terms of gender diversity :s</p>

<h3>Caveats</h3>

<ul>
<li>A lot of the time genders can't be called from an account's first name. Maybe they haven't given a first name, maybe it's a business account or some pretty unicode symbols, maybe it's a spammy egg account. This means my realised sample size is <<1000, sometimes the majority of usernames had no gender (e.g. <a href="https://twitter.com/UberSoc" target="_blank">@UberSoc</a>, fake followers?).
<p><a href="http://benjaminlmoore.files.wordpress.com/2014/05/with_missing.png"><img class="imgright" src="{{ site.baseurl }}/img/with_missing.png" alt="This (big) chart includes % for those that couldn't be assigned (NA)" width="107" height="150" /></a> This (big) chart includes % for those that couldn't be assigned (NA)</li>
<li>The SSA data is heavily biased towards Western (esp. US) and non-English names are likely to not be assigned a gender throughout. This is a shame, if you know of a more international gender DB please let me know.</li>
<li>I'm sampling most recent followers, so maybe accounts like Justin Bieber have a much higher female ratio in earlier followers than those which have only just hit the follow button.</li>
<li>The sample size of 1000 followers per account is smaller than I'd like, especially for accounts with 50 million followers.</li>
</ul>

<p>If you have other ideas of what to do with demographics data, or have noticed additional caveats of this study, please let me know in the comments!</p>

<hr />
<p style="text-align:right;">Full code to reproduce this analysis is <a title="Code to reproduce" href="https://github.com/blmoore/blogR/blob/master/R/twitter_followersGender.R" target="_blank">available on Github</a>.<br />
This post was originally published on my
<a href="http://benjaminlmoore.wordpress.com/2014/05/25/celebrity-twitter-followers-by-gender/" target="_blank">Wordpress blog</a>.</p>
