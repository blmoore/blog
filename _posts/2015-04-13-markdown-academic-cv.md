---
layout: post
title: "Building an academic CV in markdown"
categories:
- academia
tags:
- cv
- markdown
- jekyll
- webdev
status: publish
type: post
published: true
permalink: markdown-academic-cv
---

I'm creeping towards the tail-end of my PhD so it's probably time to dust off my CV and tidy it up. In the past I've written this document a few different ways, from LaTeX to a custom [Inkscape](https://inkscape.org/en/) document, but I've decided to move with the times and try something new: a markdown CV that compiles to both an HTML web version and well-formatted PDF.

## markdown-cv

Googling "markdown CV" gave a few different options: one using [pandoc](http://mszep.github.io/pandoc_resume/) with slightly dated-looking themes; another [command-line PHP script](http://there4development.com/blog/2012/12/31/markdown-resume-builder/), whose results are a bit prettier, but after trying these I came across `markdown-cv` from github user [elipapa](https://github.com/elipapa/markdown-cv) which seemed to be simple to use and came with a nice design &mdash; also it's built with [jekyll](http://jekyllrb.com/), which I already [use to power blm.io](http://blm.io/blog/wordpress-to-jekyll/).

Eliseo Papa wrote up a [blog post](http://www.eliseopapa.org/workflow/2012/09/20/why-i-switched-to-markdown-for-my-cv/) on how and why he put `markdown-cv` together, and their CV [looks great](https://github.com/elipapa/elipapa.github.io/blob/master/downloads/cv.pdf) so that was enough to convince me to give it a shot.

### HTML version

`markdown-cv` uses CSS media queries to select different stylesheets for screen and print. This means in practice you can optimise your CV design for each medium pretty easily &mdash; I went with a kind of colourful web version and more toned-down print version.

I didn't make any big changes to [elipapa's markdown-cv](https://github.com/elipapa/markdown-cv), just played with the colours, fonts, and tweaked the layout and added [font-awesome icons](http://fortawesome.github.io/Font-Awesome/).

Here's a screenshot of the current HTML version of my CV:

<a href="{{ site.baseurl }}/img/html-mdcv.png" target="_blank">
<img class="imgfull" src="{{ site.baseurl }}/img/html-mdcv.png" />
</a>

I like the whitespace and clear separation of headings, dates and details. The underlying CSS layout has some technical issues &mdash; the relative positions can get messed up on resize &mdash; but it still looks good on mobile devices and at a range of display resolutions.

### PDF version

<img class="imgright" src="{{ site.baseurl }}/img/printcv-ul.png" width="40%" />

There were a few difficulties converting the web version to print. The general approach for CVs in markdown seems to be to run [wkhtmltopdf](http://wkhtmltopdf.org/), however this uses WebKit for rendering (as the name suggests) which it turns out has issues with some modern CSS features when printing.

One issue was with CSS3 multiple `columns` layout, with `wkhtmltopdf` these were rendered in a single column while the web version renders correctly in 3-columns, across modern browsers.

<img class="imgfull" src="{{ site.baseurl }}/img/webcv-ul.png" />

It turns out support was [dropped](https://www.webkit.org/blog/88/css3-multi-column-support/#comment-16854) for printing columns specified in this way due to issues with page breaks, and apparently this still hasn't been resolved. To get around this, I convert to PDF through Firefox with its [Gecko engine](https://developer.mozilla.org/en-US/docs/Mozilla/Gecko) and all is well.

<img class="imgfull" src="{{ site.baseurl }}/img/printcv-ulfixed.png" />

Page breaks can still be iffy though, web renderers are no LaTeX, so if it doesn't break cleanly over pages you can add these in manually using CSS. For example, say you want to add a page break before your publications section:

> `cv.md`

```
## Publications

You _et al._ (2014) Some great paper...
```

> `cv-print.css`

```css

#publications {
	page-break-before: always;
}

```

There's another issue I can't debug relating to web links in the PDF version (currently some work, some don't), but in theory the PDF is for print so maybe it doesn't matter.

### Result

Here's what I have so far (click through to see the full versions) &mdash; the code is [on github](https://github.com/blmoore/md-cv) if you want to adapt it for your own use! All credit goes to the [original author](https://github.com/elipapa/markdown-cv) of markdown-cv.

<div style="float:right; width:49%;">
  <p style="text-align:center; color:#888; font-weight: bold;">PDF</p>
  <a href="https://github.com/blmoore/md-cv/blob/master/blm_cv.pdf" target="_blank">
    <img class="imgfull" src="{{ site.baseurl }}/img/printcv.png" />
  </a>
</div>

<div style="float:right; width:49%;">
  <p style="text-align:center; color:#888; font-weight: bold;">HTML</p>
  <a href="http://blm.io/cv/" target="_blank">
    <img class="imgfull" src="{{ site.baseurl }}/img/webcv.png" />
    </a>
</div>


<br clear="all" />
