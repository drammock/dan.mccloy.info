"""Fixups for HTML output; see inline comments below."""

import sys

infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile, "r") as f, open(outfile, "w") as g:
    for line in f:
        # article titles that end with question-mark
        if "?." in line:
            line = line.replace("?.", "?")
        # smallcaps
        line = line.replace("CRAN", '<span class="smallcaps">cran</span>')
        line = line.replace("DOI", '<span class="smallcaps">doi</span>')
        line = line.replace("URL", '<span class="smallcaps">url</span>')
        # LaTeX-escaped spaces
        line = line.replace(r"Conf.\ proceedings", "Conf. proceedings")
        line = line.replace(r"tech.\ reports", "tech. reports")
        g.write(line)
