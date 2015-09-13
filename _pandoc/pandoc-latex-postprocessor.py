# -*- coding: utf-8 -*-
infile = './cv.tex'
outfile = './McCloy_CV.tex'

with open(infile, 'r') as f, open(outfile, 'w') as g:
	for line in f:
		# give full references, not in-text cites
		line = line.replace('\\citep', '\\bibentry')
		# don't number sections:
		line = line.replace('\\section{', '\\section*{')
		line = line.replace('\\subsection{', '\\subsection*{')
		# pandoc generates this, don't remember why I object to it
		line = line.replace('\itemsep1pt\parskip0pt\parsep0pt', '')
		# italicize the '-er' suffix
		line = line.replace('{-er}', '\\emph{–er}')
		# convert bold to smallcaps. DANGER! Very fragile, side effects likely.
		if '\\textbf{' in line:
			line = line.replace('\\textbf{', '\\textbf{\\MakeLowercase{\osf ')
			line = line.replace('}', '}}')
		# allow line breaking at the hyphens
		line = line.replace('re-Proto-Indo-European', 're\-/Proto\-/Indo\-/European')
		# avoid italics crashing in LABS^N
		line = line.replace('\\textsuperscript{N}', '\\thinspace\\textsuperscript{N}')
		# remove indent before bullets
		line = line.replace('\\begin{itemize}', '\\begin{itemize}[leftmargin=*]')
		if '../' in line:
			line = line.replace('../bib/McCloy_CV.bib', 'http://dan.mccloy.info/bib/McCloy_CV.bib')
			line = line.replace('../pubs', 'http://dan.mccloy.info/pubs')
		g.write(line)
