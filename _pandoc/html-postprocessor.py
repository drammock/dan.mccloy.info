#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import re

infile = sys.argv[1]
outfile = sys.argv[2]

doi_regex = re.compile(r'((?:https://)doi\.org/\S+)')

with open(infile, 'r') as f, open(outfile, 'w') as g:
    for line in f:
        if '?.' in line:
            line = line.replace('?.', '?')
        if 'https://doi.org/' in line:
            line = doi_regex.sub(r'<a href="\1">DOI</a>', line)
        # smallcaps
        line = line.replace('CRAN', '<span class="smallcaps">cran</span>')
        line = line.replace('DOI', '<span class="smallcaps">doi</span>')
        g.write(line)
