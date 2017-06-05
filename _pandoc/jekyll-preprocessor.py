#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile, 'r') as f, open(outfile, 'w') as g:
	for line in f:
        # superscripts
		if '^N^' in line:
			line = line.replace('^N^', '<sup>N</sup>')
        # bibliographic references
		if '[@' in line:
			line = line.replace('[@', '{% reference ')
			line = line.replace('] ', ' %} ')
			line = line.replace(']\n', ' %}\n')
		g.write(line)
