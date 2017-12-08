#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile, 'r') as f, open(outfile, 'w') as g:
	for line in f:
		# make my name bold
		line = line.replace('{McCloy} D. R.', '{\\bfseries {McCloy} D. R.}')
		line = line.replace('{McCloy} D.R.', '{\\bfseries {McCloy} D.R.}')
		line = line.replace('{McCloy} D.', '{\\bfseries {McCloy} D.}')
		line = line.replace('{McCloy} DR', '{\\bfseries {McCloy} DR}')
		line = line.replace('{McCloy} D', '{\\bfseries {McCloy} D}')
		line = line.replace('{McCloy}', '{\\bfseries {McCloy}}')
		g.write(line)
