all: html McCloy_CV.pdf McCloy_CV_short.pdf

clean:
	@cd _parts; rm N_ART N_FIRST N_INV N_PROC N_TECHREP N_PRES N_CP_WP_TR article-title.md invited-title.md conf-pres-title.md cp-wp-tr-title.md article-omitted.md cp-wp-tr-list.md
	@rm _cv.md _cv_short.md

# computed values

_parts/N_ART: _parts/article-list.md
	@cd _parts; wc -l article-list.md | cut -d " " -f 1 > N_ART

_parts/N_FIRST: _parts/article-list.md
	@cd _parts; grep -c "@McCloy" article-list.md > N_FIRST

_parts/N_INV: _parts/invited-list.md
	@cd _parts; wc -l invited-list.md | cut -d " " -f 1 > N_INV

_parts/N_PROC: _parts/conf-proc-list.md
	@cd _parts; wc -l conf-proc-list.md | cut -d " " -f 1 > N_PROC

_parts/N_TECHREP: _parts/tech-rep-list.md
	@cd _parts; wc -l tech-rep-list.md | cut -d " " -f 1 > N_TECHREP

_parts/N_PRES: _parts/conf-pres-list.md
	@cd _parts; wc -l conf-pres-list.md | cut -d " " -f 1 > N_PRES

_parts/N_CP_WP_TR: _parts/cp-wp-tr-list.md
	@cd _parts; wc -l cp-wp-tr-list.md | cut -d " " -f 1 > N_CP_WP_TR


# content (mostly section titles) that includes computed values

_parts/article-title.md: _parts/N_ART _parts/N_FIRST
	@cd _parts; echo "\n## Peer-reviewed articles ($$(cat N_ART;) total, $$(cat N_FIRST;) first-authored)" > article-title.md

_parts/invited-title.md: _parts/N_INV
	@cd _parts; echo "\n## Invited talks ($$(cat N_INV;))" > invited-title.md

_parts/conf-pres-title.md: _parts/N_PRES
	@cd _parts; echo "\n## Conference presentations ($$(cat N_PRES;))" > conf-pres-title.md

_parts/cp-wp-tr-title.md: _parts/N_CP_WP_TR
	@cd _parts; echo "\n## Conference proceedings, working papers & technical reports ($$(cat N_CP_WP_TR;))" > cp-wp-tr-title.md

_parts/article-omitted.md: _parts/N_INV _parts/N_PROC _parts/N_TECHREP _parts/N_PRES
	@cd _parts; echo "*Omitted here:* $$(cat N_INV;) invited talks, $$(cat N_PROC;) conference proceedings, $$(cat N_TECHREP;) technical report, $$(cat N_PRES;) conference presentations. [Comprehensive BibTeX available here](../bib/McCloy_CV.bib).\n" > article-omitted.md


# aggregated lists

_parts/cp-wp-tr-list.md: _parts/conf-proc-list.md _parts/tech-rep-list.md _parts/working-paper-list.md
	@cd _parts; cat conf-proc-list.md tech-rep-list.md working-paper-list.md | sort -n -r -t 2 -k 2 > cp-wp-tr-list.md


# whole document

_cv.md: _parts/frontmatter.md _parts/overview.md _parts/biblink.md _parts/degrees.md _parts/other-education.md _parts/teaching.md _parts/tech-skills.md _parts/software-corpora.md _parts/article-title.md _parts/article-list.md _parts/invited-title.md _parts/invited-list.md _parts/cp-wp-tr-title.md _parts/cp-wp-tr-list.md _parts/conf-pres-title.md _parts/conf-pres-list.md _parts/service-conf-comm.md _parts/service-journal-rev.md _parts/service-mentor-outreach.md _parts/grant-fellow-award.md _parts/affil.md
	@cd _parts; cat frontmatter.md \
					overview.md \
					biblink.md \
					degrees.md \
					other-education.md \
					teaching.md \
					tech-skills.md \
					software-corpora.md \
					article-title.md \
					article-list.md \
					invited-title.md \
					invited-list.md \
					cp-wp-tr-title.md \
					cp-wp-tr-list.md \
					conf-pres-title.md \
					conf-pres-list.md \
					service-conf-comm.md \
					service-journal-rev.md \
					service-mentor-outreach.md \
					grant-fellow-award.md \
					affil.md \
					lang.md > ../_cv.md

_cv_short.md: _parts/article-omitted.md _cv.md
	@cd _parts; cat frontmatter.md \
					overview.md \
					degrees.md \
					other-education.md \
					teaching.md \
					tech-skills.md \
					software-corpora.md \
					clearpage \
					article-title.md \
					article-omitted.md \
					article-list.md \
					service-conf-comm.md \
					service-mentor-outreach.md \
					grant-fellow-award.md > ../_cv_short.md

# PDFs

McCloy_CV.pdf: _cv.md
	@pandoc --natbib --from markdown-smart --template=_pandoc/template-cv.tex --output=_pandoc/cv.tex _cv.md
	@cd _pandoc; python latex-postprocessor.py cv.tex McCloy_CV.tex
	@cd _pandoc; bash compile-pdf.bash McCloy_CV.tex
	@mv _pandoc/McCloy_CV.pdf .
	@cd _pandoc; rm cv.tex McCloy_CV.tex

McCloy_CV_short.pdf: _cv_short.md
	@pandoc --natbib --from markdown-smart --template=_pandoc/template-cv-short.tex --output=_pandoc/cv-short.tex _cv_short.md
	@cd _pandoc; python latex-postprocessor.py cv-short.tex McCloy_CV_short.tex
	@cd _pandoc; bash compile-pdf.bash McCloy_CV_short.tex
	@mv _pandoc/McCloy_CV_short.pdf .
	@cd _pandoc; rm cv-short.tex McCloy_CV_short.tex


# HTML version

cv.md: _cv.md
	python _pandoc/jekyll-preprocessor.py _cv.md cv.md

serve: cv.md
	bundle exec jekyll serve

html: cv.md
	bundle exec jekyll build
	python _pandoc/html-postprocessor.py _site/cv/index.html _site/cv/tmp.html
	mv _site/cv/tmp.html _site/cv/index.html

# alternate versions
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
