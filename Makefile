all: html McCloy_CV.pdf McCloy_CV_short.pdf McCloy_resume.pdf

.PHONY: _auto/

clean:
	@rm -r _auto
	@rm cv.md _cv.md _cv_short.md _resume.md

# computed values

_auto/:
	@mkdir -p _auto

_auto/N_ART: _parts/article-list.md _auto/
	@cd _parts; wc -l article-list.md | cut -d " " -f 1 > ../_auto/N_ART

_auto/N_FIRST: _parts/article-list.md _auto/
	@cd _parts; grep -c "@McCloy" article-list.md > ../_auto/N_FIRST

_auto/N_INV: _parts/invited-list.md _auto/
	@cd _parts; wc -l invited-list.md | cut -d " " -f 1 > ../_auto/N_INV

_auto/N_PROC: _parts/conf-proc-list.md _auto/
	@cd _parts; wc -l conf-proc-list.md | cut -d " " -f 1 > ../_auto/N_PROC

_auto/N_TECHREP: _parts/tech-rep-list.md _auto/
	@cd _parts; wc -l tech-rep-list.md | cut -d " " -f 1 > ../_auto/N_TECHREP

_auto/N_PRES: _parts/conf-pres-list.md _auto/
	@cd _parts; wc -l conf-pres-list.md | cut -d " " -f 1 > ../_auto/N_PRES

_auto/N_PREPRINT: _parts/preprint-list.md _auto/
	@cd _parts; wc -l preprint-list.md | cut -d " " -f 1 > ../_auto/N_PREPRINT

_auto/N_CP_WP_TR: _auto/cp-wp-tr-list.md _auto/
	@cd _auto; wc -l cp-wp-tr-list.md | cut -d " " -f 1 > N_CP_WP_TR


# content (mostly section titles) that includes computed values

_auto/article-title.md: _auto/N_ART _auto/N_FIRST
	@cd _auto; echo "\n## Peer-reviewed articles ($$(cat N_ART;) total, $$(cat N_FIRST;) first-authored)" > article-title.md

_auto/invited-title.md: _auto/N_INV
	@cd _auto; echo "\n## Invited talks ($$(cat N_INV;))" > invited-title.md

_auto/conf-pres-title.md: _auto/N_PRES
	@cd _auto; echo "\n## Conference presentations ($$(cat N_PRES;))" > conf-pres-title.md

_auto/cp-wp-tr-title.md: _auto/N_CP_WP_TR
	@cd _auto; echo "\n## Conf.\ proceedings, preprints, working papers & tech.\ reports ($$(cat N_CP_WP_TR;))" > cp-wp-tr-title.md

_auto/article-omitted.md: _auto/N_INV _auto/N_PROC _auto/N_TECHREP _auto/N_PRES _auto/N_PREPRINT
	@cd _auto; echo "*Omitted here:* $$(cat N_INV;) invited talks, $$(cat N_PROC;) conference proceedings, $$(cat N_TECHREP;) technical report, $$(cat N_PRES;) conference presentations, $$(cat N_PREPRINT;) preprints. [Comprehensive BibTeX available here](../bib/McCloy_CV.bib).\n" > article-omitted.md

_auto/publication-summary.md: _auto/N_ART _auto/N_FIRST _auto/N_INV _auto/N_PROC _auto/N_TECHREP _auto/N_PRES _auto/N_PREPRINT
	@cd _auto; echo "\n## Scholarly output\n\n$$(cat N_ART;) Peer-reviewed articles ($$(cat N_FIRST;) first-authored), $$(cat N_INV;) invited talks, $$(cat N_PROC;) conference proceedings, $$(cat N_TECHREP;) technical report$$(../plural N_TECHREP;), $$(cat N_PRES;) conference presentations, $$(cat N_PREPRINT;) preprint$$(../plural N_PREPRINT;). [Full list here](https://dan.mccloy.info/cv/), [comprehensive BibTeX here](../bib/McCloy_CV.bib).\n" > publication-summary.md

# aggregated lists

_auto/cp-wp-tr-list.md: _parts/conf-proc-list.md _parts/tech-rep-list.md _parts/working-paper-list.md _parts/preprint-list.md
	@cd _parts; cat conf-proc-list.md tech-rep-list.md working-paper-list.md preprint-list.md | sort -n -r -t 2 -k 2 > ../_auto/cp-wp-tr-list.md


# whole document

_cv.md: _parts/frontmatter.md _parts/overview.md _parts/biblink.md _parts/degrees.md _parts/other-education.md _parts/teaching.md _parts/tech-skills.md _parts/software-corpora.md _auto/article-title.md _parts/article-list.md _auto/invited-title.md _parts/invited-list.md _auto/cp-wp-tr-title.md _auto/cp-wp-tr-list.md _auto/conf-pres-title.md _parts/conf-pres-list.md _parts/service-conf-comm.md _parts/service-journal-rev.md _parts/service-mentor-outreach.md _parts/grant-fellow-award.md _parts/affil.md
	@cd _parts; cat frontmatter.md \
					overview.md \
					biblink.md \
					degrees.md \
					other-education.md \
					teaching.md \
					tech-skills.md \
					software-corpora.md \
					../_auto/article-title.md \
					article-list.md \
					../_auto/invited-title.md \
					invited-list.md \
					../_auto/cp-wp-tr-title.md \
					../_auto/cp-wp-tr-list.md \
					../_auto/conf-pres-title.md \
					conf-pres-list.md \
					service-conf-comm.md \
					service-journal-rev.md \
					service-mentor-outreach.md \
					grant-fellow-award.md \
					affil.md > ../_cv.md
# lang.md removed from last position (temporarily?)

_cv_short.md: _auto/article-omitted.md _cv.md
	@cd _parts; cat frontmatter.md \
					overview.md \
					degrees.md \
					other-education.md \
					teaching.md \
					tech-skills.md \
					software-corpora.md \
					clearpage \
					../_auto/article-title.md \
					../_auto/article-omitted.md \
					article-list.md \
					service-conf-comm.md \
					service-mentor-outreach.md \
					grant-fellow-award.md > ../_cv_short.md

_resume.md: _cv_short.md _parts/overview-resume.md _parts/tech-skills-resume.md _parts/jobs.md _parts/education-resume.md _parts/teaching-resume.md _auto/publication-summary.md _parts/software-corpora-resume.md _parts/service-summary-resume.md _parts/grant-fellow-award-resume.md
	@cd _parts; cat frontmatter.md \
					overview-resume.md \
					tech-skills-resume.md \
					jobs.md \
					education-resume.md \
					teaching-resume.md \
					../_auto/publication-summary.md \
					software-corpora-resume.md \
					service-summary-resume.md \
					grant-fellow-award-resume.md > ../_resume.md


# PDFs

McCloy_CV.pdf: _cv.md _pandoc/template-cv.tex
	@pandoc --natbib --from markdown-smart --template=_pandoc/template-cv.tex --output=_pandoc/cv.tex _cv.md
	@cd _pandoc; python latex-postprocessor.py cv.tex McCloy_CV.tex
	@cd _pandoc; bash compile-pdf.bash McCloy_CV.tex
	@mv _pandoc/McCloy_CV.pdf .
	@cd _pandoc; rm cv.tex McCloy_CV.tex

McCloy_CV_short.pdf: _cv_short.md _pandoc/template-cv-short.tex
	@pandoc --natbib --from markdown-smart --template=_pandoc/template-cv-short.tex --output=_pandoc/cv-short.tex _cv_short.md
	@cd _pandoc; python latex-postprocessor.py cv-short.tex McCloy_CV_short.tex
	@cd _pandoc; bash compile-pdf.bash McCloy_CV_short.tex
	@mv _pandoc/McCloy_CV_short.pdf .
	@cd _pandoc; rm cv-short.tex McCloy_CV_short.tex

McCloy_resume.pdf: _resume.md _pandoc/template-resume.tex
	@pandoc --natbib --from markdown-smart --template=_pandoc/template-resume.tex --output=_pandoc/resume.tex _resume.md
	@cd _pandoc; python latex-postprocessor.py resume.tex McCloy_resume.tex
	@cd _pandoc; bash compile-pdf.bash McCloy_resume.tex
	@mv _pandoc/McCloy_resume.pdf .
	@cd _pandoc; rm resume.tex McCloy_resume.tex

# HTML version

cv.md: _cv.md
	python _pandoc/jekyll-preprocessor.py _cv.md cv.md

serve: cv.md
	bundle exec jekyll serve

html: cv.md
	bundle exec jekyll build
	python _pandoc/html-postprocessor.py _site/cv/index.html _site/cv/tmp.html
	mv _site/cv/tmp.html _site/cv/index.html

datascience: _resume/resume_datascience.md
	@pandoc _resume/resume_datascience.md \
	--from markdown-smart \
	--pdf-engine=xelatex \
	--template=_pandoc/template-resume.tex \
	--output=McCloy_datascience_resume.pdf
