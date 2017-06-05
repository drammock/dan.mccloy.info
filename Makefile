serve: cv
	bundle exec jekyll serve

html: cv
	bundle exec jekyll build
	python _pandoc/html-postprocessor.py _site/cv/index.html _site/cv/tmp.html
	mv _site/cv/tmp.html _site/cv/index.html

pdf:
	# convert markdown to latex source
	pandoc --natbib --no-tex-ligatures --template=_pandoc/template-cv.tex \
	--output=_pandoc/cv.tex _cv.md
	# clean up vestiges of markdown in latex source
	cd _pandoc; python latex-postprocessor.py cv.tex McCloy_CV.tex
	# compile PDF
	cd _pandoc; bash compile-pdf.bash McCloy_CV.tex
	mv _pandoc/McCloy_CV.pdf .
	# clean up
	rm _pandoc/cv.tex

cv: _cv.md
	python _pandoc/jekyll-preprocessor.py _cv.md cv.md

all: pdf html
