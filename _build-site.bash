#! /bin/bash

bundle exec jekyll build
cd _pandoc/
python jekyll-scholar-html-postprocessor.py
cd ../
mv _site/cv/tmp.html _site/cv/index.html
