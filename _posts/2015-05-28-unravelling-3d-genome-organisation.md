---
layout: post
title: "Unravelling 3D genome organisation"
categories:
- academia
tags:
- phd
- hi-c
- 3dgenome
- open-science
status: publish
type: post
published: true
permalink: 3d-genome-organisation
---

The first paper of my PhD is finally out! Its full title is "[Integrative modeling reveals the principles of multi-scale chromatin boundary formation in human nuclear organization](http://genomebiology.com/2015/16/1/110)" but in talks and posters I've been referring to the project as "Unravelling higher order chromatin organisation" (geddit?) or even "the ENCODE-ing of ..." (referencing [ENCODE](https://www.encodeproject.org/), of course).

This project was done entirely with open data, I've made my code [open source](https://github.com/blmoore/3dgenome) and in the interests of open science I thought I'd write up a blog summary of the paper.

## Data

The project came out of the observation (made a couple of years ago now) that Hi-C datasets were available for each of the tier 1 ENCODE human cell lines: meaning we had access to an unprecedented amount of matched chromatin data.

<div style="margin: 0 auto 10px auto; width: 91%">
<img src="{{site.baseurl}}/img/lieberman2009.png" width="30%" />
<img src="{{site.baseurl}}/img/kalhor2011.png" width="30%" />
<img src="{{site.baseurl}}/img/dixon2012.png" width="30%" />
</div>

Though now better sources are available, when we started there were three human Hi-C papers we gathered data from : the original Hi-C paper ([Leiberman Aiden _et al._, 2009](dx.doi.org/10.1126/science.1181369)); an improved method, TCC, with also ran Hi-C for comparison ([Kalhor _et al._, 2011](http://dx.doi.org/10.1038/nbt.2057)); and a much more-deeply sequenced dataset that first reported TADs ([Dixon _et al._, 2012](dx.doi.org/10.1038/nature11082)). These papers produced genome-wide Hi-C data for human cell types K562, Gm12878 and H1 hESC respectively, and as mentioned, these are the [ENCODE tier 1 cell lines](http://www.genome.gov/26524238).

<img class="imgfull" src="{{site.baseurl}}/img/encode_celllines.png" />

These Hi-C datasets were produced by different labs, using slightly different protocols and with varying levels of sequencing. With this in mind, directly comparing contacts is going to be tricky, even after thorough normalisation. In our analysis, we relied mostly on abstracted measures of chromatin conformation: compartment eigenvectors, TAD calls or within cell-line contacts only.

## Analysis

Broadly we were interested in how chromatin features are related to genome conformation. The main questions we try to address in the manuscript boil down to:

1. To what extent does higher order chromatin structure &mdash; by which I mostly mean megabase-sized topological domains and multi-megabase chromosome compartments &mdash; vary between cell types, and is there interesting biology where they're discordant?

2. How do chromatin features (like histone modifications, transcription factors) connect to what's going on at the level of higher-order chromatin structure? What can we learn the rules underlying this relationship?

3. How do the boundary regions demarcating higher-order domains vary between cell types?

### 1. Genome organisation pretty similar across human cell types

After re-processing each Hi-C data uniformly from raw sequencing reads (and applying [iterative correction](http://dx.doi.org/10.1038/nmeth.2148)), it wasn't a huge suprise to find a broad agreement of higher-order chromatin structure between human cell types.[^1]

Along the left-hand side of figure 1 I'm plotting the principal component eigenvector derived from Hi-C contact maps (reflecting A/B compartment profile, following [Leiberman Aiden _et al._, 2009](dx.doi.org/10.1126/science.1181369)). You can see cell type profiles track one another along the chromosome, the genome-wide Pearson correlation of these values a 1 Mb resolution was around 0.80.

<a href="{{site.baseurl}}/img/f1_full.png" target="_blank"><img class="imgfull" src="{{site.baseurl}}/img/f1_thumb.png" /></a>

Similarly at the level of TADs &mdash; shaded rectangles in the zoomed region &mdash; there's a decent agreement between cell types. Despite the sub-optimal TAD-calling algorithm (the published [Dixon _et al._, 2012](dx.doi.org/10.1038/nature11082)) and a sparse contact map given the resolution (particularly in K562), there was still around a third of boundaries in one cell type that could be very precisely mapped to boundaries in the other two.

[^1]: Of course these are probabilistic frequencies derived from cell populations rather than the individual cell comparisons achievable with [single cell Hi-C](dx.doi.org/10.1038/nature12593)

### 2. Chromatin features predict aspects of genome architecture

In short we built [Random Forest regression models](http://blm.io/talks/bsa/figure/rfp.png) to predict the continuous compartment profile (the blue line in the above figure), and it achieved high accuracy. This wasn't wholly surprising: strong correlations between individual input variables and compartment profile has already been reported (even in the original [Leiberman Aiden paper](dx.doi.org/10.1126/science.1181369)), so the interest really comes from dissecting and cross-applying these models, rather than from their raw metrics.

<a href="{{site.baseurl}}/img/f2_full.png" target="_blank"><img class="imgfull" src="{{site.baseurl}}/img/f2_thumb.png" /></a>

We found that models learned in one cell-type had almost as much predictive power in another cell type, suggested common rules governing higher order structure. However, we've already seen that much of this structure is the same between cell types, so are these fixed regions inflating our accuracy measures?

<a href="{{site.baseurl}}/img/f4_full.png" target="_blank"><img class="imgfull" src="{{site.baseurl}}/img/f4_thumb.png" /></a>

It turns out that yes, if you split your input dataset by how variable these regions are between cell types, it turns out those most variable regions are more difficult to predict (**A**, _above_).

This raises another question: are these variable regions in some way more noisy or is there something interesting going on? The right panel (**B**, _above_) tries to address this by doing some functional analysis. The results were that "flipped" open regions (e.g. a megabase active in Gm12878, but a closed, repressive compartment in the other two human cell types) showed an enrichment for predicted enhancer chromatin states,[^2] potentially highlighting areas of cell-type specific gene activation. We followed this up by picking out some examples (**A**, _below_) and returning to Hi-C contacts to look for changes in long-range interactions.

<a href="{{site.baseurl}}/img/f5ex_full.png" target="_blank"><img class="imgfull" src="{{site.baseurl}}/img/f5ex_thumb.png" /></a>

[^2]: Predicted by `ChromHMM` and `SegWay` [consensus annotations](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3553955/)

### 3. Domain boundaries enriched for lots of things

The last part of the paper I want to mention was an analysis of domain boundary enrichments. TAD boundaries were brought to the fore by [Dixon _et al._ (2012)](dx.doi.org/10.1038/nature11082), but there's been debate about how important or interesting these spacers are. Are boundaries _responsible_ for domains (i.e. binding of insulators and other factors blocks heterochromatin expansion) or are boundaries just "what's left" when an active domain is adjacent to, say, a repressive lamina-associated domain?

While we couldn't resolve that debate in this paper, we were still interested in comparing TAD boundaries across cell types, as well as looking at compartment boundaries too. We also statistically tested the enrichment of each feature, rather than just showing the "average-o-gram" profiles.

<a href="{{site.baseurl}}/img/f6_full.png" target="_blank"><img class="imgfull" src="{{site.baseurl}}/img/f6_thumb.png" /></a>

The results recap some of the known TAD enrichments (CTCF, Pol2) but also find an overlapping range of peaked features at compartment boundaries, and at a broader scale.

## Summary

Overall we found higher order chromatin structure is well-conserved between human cell types and well-described by locus-level chromatin features, but divergent regions contain cell-type-specific biology that could be cause or consequence of these differences. Our difficulties predicting these more flexible regions could be due to missing input features from our datasets or, more likely in my view, local activation and repression mechanisms not captured by a genome-wide model.

### Links

I've given a very brief overview of a lot of work, please do check out [the paper](http://genomebiology.com/2015/16/1/110) if interested. It comes with the obligatory [lengthy supplementary materials](http://genomebiology.com/content/pdf/s13059-015-0661-x.pdf) full of more good stuff.
<a href="http://figshare.com/articles/Unravelling_higher_order_chromatin_structure/866781" target="_blank"><img class="imgright" width="30%" src="{{site.baseurl}}/img/poster2.png" /></a>

* Code to reproduce all analyses shown in the paper and supplementary is avaiable on github: [github.com/blmoore/3dgenome](https://github.com/blmoore/3dgenome)

* Posters related to this project have been shared on [figshare](http://figshare.com/articles/Unravelling_higher_order_chromatin_organisation/1379863).

* Slides are available for [a talk I gave](http://blm.io/talks/bsa/) at a local research group meet-up.

<br clear="all" />
