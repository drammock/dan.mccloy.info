# -*- coding: utf-8 -*-
infile = '../_cv-edit-this-one.md'
outfile = '../cv.md'

with open(infile, 'r') as f, open(outfile, 'w') as g:
	for line in f:
		if '^N^' in line:
			line = line.replace('^N^', '<sup>N</sup>')
		if '[@' in line:
			line = line.replace('[@', '{% reference ')
			line = line.replace('] ', ' %} ')
			line = line.replace(']\n', ' %}\n')
		g.write(line)
