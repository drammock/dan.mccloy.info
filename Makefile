serve: cv
	bundle exec jekyll serve

html: cv
	bundle exec jekyll build
	python _pandoc/html-postprocessor.py _site/cv/index.html _site/cv/tmp.html
	mv _site/cv/tmp.html _site/cv/index.html

_pandoc/cv.tex: _cv.md
	# convert markdown to latex source
	pandoc --natbib --from markdown-smart --template=_pandoc/template-cv.tex \
	--output=_pandoc/cv.tex _cv.md

_pandoc/McCloy_CV.tex: _pandoc/cv.tex
	# clean up vestiges of markdown in latex source
	cd _pandoc; python latex-postprocessor.py cv.tex McCloy_CV.tex

pdf: _pandoc/McCloy_CV.tex
	# compile PDF
	cd _pandoc; bash compile-pdf.bash McCloy_CV.tex
	mv _pandoc/McCloy_CV.pdf .
	# clean up
	rm _pandoc/cv.tex

cv: _cv.md
	python _pandoc/jekyll-preprocessor.py _cv.md cv.md

resume: _resume/resume.md
	@pandoc _resume/resume.md \
	--from markdown-smart \
	--pdf-engine=xelatex \
	--template=_pandoc/template-resume.tex \
	--output=McCloy_resume.pdf

datascience: _resume/resume_datascience.md
	@pandoc _resume/resume_datascience.md \
	--from markdown-smart \
	--pdf-engine=xelatex \
	--template=_pandoc/template-resume.tex \
	--output=McCloy_datascience_resume.pdf

_pandoc/cv-short.tex: _cv-short.md
	# convert markdown to latex source
	pandoc --natbib --from markdown-smart \
	--template=_pandoc/template-cv-short.tex \
	--output=_pandoc/cv-short.tex _cv-short.md

_pandoc/McCloy_CV_short.tex: _pandoc/cv-short.tex
	# clean up vestiges of markdown in latex source
	cd _pandoc; python latex-postprocessor.py cv-short.tex McCloy_CV_short.tex

short: _pandoc/McCloy_CV_short.tex
	# compile PDF
	cd _pandoc; bash compile-pdf.bash McCloy_CV_short.tex
	mv _pandoc/McCloy_CV_short.pdf .
	# clean up
	rm _pandoc/cv-short.tex

all: pdf html
