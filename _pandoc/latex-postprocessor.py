#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile, 'r') as f, open(outfile, 'w') as g:
	for line in f:
		# give full references, not in-text cites
		line = line.replace('\\citep', '\\bibentry')
		# don't number sections:
		line = line.replace('\\section{', '\\section*{')
		line = line.replace('\\subsection{', '\\subsection*{')
		line = line.replace('\\subsubsection{', '\\subsubsection*{')
		# pandoc generates this, don't remember why I object to it
		# line = line.replace('\itemsep1pt\parskip0pt\parsep0pt', '')
		# italicize the '-er' suffix
		line = line.replace('{-er}', '\\emph{–er}')
		# allow line breaking at the hyphens
		line = line.replace('re-Proto-Indo-European', 're\-/Proto\-/Indo\-/European')
		# avoid italics crashing in LABS^N
		line = line.replace('\\textsuperscript{N}', '\\thinspace\\textsuperscript{N}')
		# remove indent before bullets
		line = line.replace('\\begin{itemize}', '\\begin{itemize}[leftmargin=*]')
        # convert relative to absolute paths
		if '../' in line:
			line = line.replace('../bib/McCloy_CV.bib', 'http://dan.mccloy.info/bib/McCloy_CV.bib')
			line = line.replace('../pubs', 'http://dan.mccloy.info/pubs')
		g.write(line)
