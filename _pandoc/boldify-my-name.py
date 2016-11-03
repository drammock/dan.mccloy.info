# -*- coding: utf-8 -*-
infile = './McCloy_CV.bbl.bak'
outfile = './McCloy_CV.bbl'

with open(infile, 'r') as f, open(outfile, 'w') as g:
	for line in f:
		# make my name bold
		line = line.replace('{McCloy} D.', '{\\bfseries {McCloy} D.}')
		g.write(line)
