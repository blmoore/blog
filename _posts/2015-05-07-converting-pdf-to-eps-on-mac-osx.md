---
layout: post
title: "Converting PDF to EPS on OS X"
categories:
- unix
tags:
- pdf
- inkscape
- ghostscript
- eps
- images
status: publish
type: post
published: true
permalink: convert-pdf-eps-osx
---

Recently I discovered that some academic publishers will let you submit PDF figures right up until acceptance, where they then need to be in an "editable" format. Vector figures inside PDF containers _are_ editable of course, but the author guidelines for your journal of choice may well say otherwise, instead offering a list of ancient and bewildering image formats which are deemed acceptable. It's baffling to me why a journal would prefer a `pptx` PowerPoint file containing your figure than a modern open standard like `SVG` (not a format without consistency issues, admittedly). So for this reason I needed to convert a bunch of PDF figures to EPS (encapsulated postscript) without too much manual effort.

## Conversions

Google lead me to [tex.se](http://tex.stackexchange.com/q/20883) where a [great answer](http://tex.stackexchange.com/a/20884) (+1) lists a few different possible methods of going about this conversion. After trying a couple, it turned out the results were often imperfect and sometimes wildly different.

As an example PDF vector image, here's the [measles heatmap I put together](https://benjaminlmoore.wordpress.com/2015/04/09/recreating-the-vaccination-heatmaps-in-r/) recently:

<img class="imgfull" src="{{ site.baseurl }}/img/measles_hm.png" />

### ImageMagick

How well does this convert with, say, [ImageMagick](http://www.imagemagick.org/):

```sh
convert measles.pdf measles_imagemagick.eps
```

<img class="imgfull" src="{{ site.baseurl }}/img/measles_imagemagick.png" />

Wow, I have no idea why that gives such a bad result, maybe it could be improved by tweaking some [parameters](http://www.imagemagick.org/script/convert.php) but I didn't experiment with these.

### Inkscape

Better results came from [Inkscape](https://inkscape.org/en/) (though linking the commandline version is [a pain](http://wiki.inkscape.org/wiki/index.php/MacOS_X#Inkscape_command_line) on OS X):

```sh
inkscape measles.pdf --export-eps=measles_inkscape.eps
```

<img class="imgfull" src="{{ site.baseurl }}/img/measles_inkscape.png" />

This looks a bit better, though the bounding box is tightly cropped.

### pdftops (xpdf)

The best out-of-the-box result with this file came from `pdftops` (part of [xpdf](http://www.foolabs.com/xpdf/download.html)) which maintained PDF margins and converted vector elements reasonably faithfully:

```bash
pdftops -eps measles.pdf
```

<img class="imgfull" src="{{ site.baseurl }}/img/measles_pdftops.png" />

## Script

To quickly try each of the above methods (and more) I've put a rough bash script together [`pdf2eps`](https://github.com/blmoore/pdf2eps-osx) that can be cloned from [github](https://github.com/blmoore) and run as:

```sh
git clone git://github.com/blmoore/pdf2eps-osx
cd pdf2eps-osx
./pdf2eps example_file.pdf
# Converting: example_file.pdf

ls converted/
# example_file_gs.eps          example_file_inkscape.eps
# example_file_imagemagick.eps example_file_pdftops.eps
```

Maybe I'll properly develop this script in future, using getopts and testing/installing linked programs, but for now it works as a quick hack!
