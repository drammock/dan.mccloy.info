---
layout: page
title: "Tutorials"
---

Here are a few tutorials I’ve written up over the years.

# Spectrograms
This is a walkthrough of how to make spectrograms in python that are customized for human speech research.  The built-in functions `scipy.signal.spectrogram` and `matplotlib.pyplot.specgram` are both very general-purpose, so this tutorial defines a wrapper function to make the parameters more sensible for phoneticians and speech scientists.

> [repo](https://github.com/drammock/spectrogram-tutorial) \| [notebook](https://github.com/drammock/spectrogram-tutorial/blob/master/spectrogram.ipynb)

# Plotting diphthongs
This tutorial goes through some of the considerations around diphthong plotting (chiefly deciding how many time points to plot).  There are R and python versions (both are [Jupyter notebooks](http://jupyter.org/)), which differ slightly but cover the same basic material.  Originally presented at a meeting of the UW Phonetics Lab, 2017-11-03.

> [repo](https://github.com/drammock/diphthong-plotting-tutorial) \| [R notebook](https://github.com/drammock/diphthong-plotting-tutorial/blob/master/diphthong-plotting-R.ipynb) \| [python notebook](https://github.com/drammock/diphthong-plotting-tutorial/blob/master/diphthong-plotting.ipynb)

# Logistic regression
This tutorial uses R to go through a simple example of modeling a binary variable smapled over a period of time.  Data points are assumed independent, so there is no “within-subjects” aspect; just an ordinary generalized linear model using a logit link.  Code for how the data were simulated is provided at the end.

> [repo](https://github.com/drammock/logistic-regression-tutorial) \| [R notebook](https://github.com/drammock/logistic-regression-tutorial/blob/master/logistic-regression-tutorial.ipynb)

# Using the phonR package
This is the tutorial vignette for the R package `phonR`.  It works better as a website than a PDF, and this way the package doesn’t take up extra space on CRAN’s servers.

> http://drammock.github.io/phonR/
