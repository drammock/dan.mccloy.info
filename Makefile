website: cv site

cv:
	cd _pandoc; pandoc --from=markdown-auto_identifiers --natbib --no-tex-ligatures \
	--template=cv-template.tex --output=cv.tex ../_cv-edit-this-one.md
	cd _pandoc; python pandoc-latex-postprocessor.py
	cd _pandoc; python convert-pandoc-refs-to-liquid.py
	cd _pandoc; sh compile.bash McCloy_CV.tex
	mv _pandoc/McCloy_CV.pdf ./
	cd _pandoc; rm -f cv.tex McCloy_CV.* *.pyc

site:
	bundle exec jekyll build
	cd _pandoc; python jekyll-scholar-html-postprocessor.py
	mv _site/cv/tmp.html _site/cv/index.html

resume:
	cd _pandoc; pandoc --from=markdown-auto_identifiers --no-tex-ligatures \
	--template=resume-template.tex --output=resume.tex ../_resume.markdown
	cd _pandoc; python pandoc-latex-postprocessor-resume.py
	cd _pandoc; sh compile.bash McCloy_resume.tex
	mv _pandoc/McCloy_resume.pdf ./
	cd _pandoc; rm -f resume.tex McCloy_resume.* *.pyc
