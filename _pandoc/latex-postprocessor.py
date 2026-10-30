"""Fixups for PDF output; see inline comments below."""

import sys

infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile, "r") as f, open(outfile, "w") as g:
    for line in f:
        # give full references, not in-text cites
        line = line.replace(r"\citep", r"\bibentry")
        # don't number sections:
        line = line.replace(r"\section{", r"\section*{")
        line = line.replace(r"\subsection{", r"\subsection*{")
        line = line.replace(r"\subsubsection{", r"\subsubsection*{")
        # italicize the '-er' suffix
        line = line.replace("{-er}", r"\emph{–er}")
        # allow line breaking at the hyphens
        line = line.replace("re-Proto-Indo-European", r"re\-/Proto\-/Indo\-/European")
        # avoid italics crashing in LABS^N
        # line = line.replace(r'\textsuperscript{N}',
        #                     r'\thinspace\textsuperscript{N}')
        # remove indent before bullets
        line = line.replace(r"\begin{itemize}", r"\begin{itemize}[leftmargin=*]")
        # convert relative to absolute paths
        if "../" in line:
            line = line.replace(
                "../bib/McCloy_CV.bib", "https://dan.mccloy.info/bib/McCloy_CV.bib"
            )
            line = line.replace("../pubs", "https://dan.mccloy.info/pubs")
        g.write(line)
