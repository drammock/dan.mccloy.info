"""Set initialisms/acronyms in smallcaps in PDF output."""

import sys

infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile, "r") as f, open(outfile, "w") as g:
    for line in f:
        # smallcaps
        line = line.replace("CRAN", "\\textsc{cran}")
        line = line.replace("DOI", "\\textsc{doi}")
        g.write(line)
