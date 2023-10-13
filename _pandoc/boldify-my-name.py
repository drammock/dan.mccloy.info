#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile, "r") as f, open(outfile, "w") as g:
    for line in f:
        if r"\bibitem[" not in line:
            line = line.replace("{McCloy}", r"{\ego McCloy}")
        g.write(line)
