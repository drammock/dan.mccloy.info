#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile, 'r') as f, open(outfile, 'w') as g:
	for line in f:
		if '?.' in line:
			line = line.replace('?.', '?')
		if 'dx.doi.org' in line:
			line = line.replace('>http://dx.doi.org/', '>')
		g.write(line)
