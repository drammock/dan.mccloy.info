# -*- coding: utf-8 -*-
infile = './nsf-biosketch.tex'
outfile = './McCloy-NSF-biosketch.tex'

with open(infile, 'r') as f, open(outfile, 'w') as g:
	for line in f:
		# give full references, not in-text cites
		line = line.replace('\\citep', '\\bibentry')
		# don't number sections:
		line = line.replace('\\section{', '\\section*{')
		line = line.replace('\\subsection{', '\\subsection*{')
		# pandoc generates this, don't remember why I object to it
		line = line.replace('\itemsep1pt\parskip0pt\parsep0pt', '')
		# remove indent before bullets
		line = line.replace('\\begin{itemize}', '\\begin{itemize}[leftmargin=*]')
		g.write(line)
