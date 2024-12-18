#! /bin/bash
bn=$(basename $1 .tex)
mv "$bn.tex" "$bn.tex.bak"
python smallcap-acronyms.py "$bn.tex.bak" "$bn.tex"
xelatex $1
bibtex8 "$bn"
mv "$bn.bbl" "$bn.bbl.bak"
python boldify-my-name.py "$bn.bbl.bak" "$bn.bbl"
xelatex $1
xelatex $1
for ext in aux ent fff log lof lol lot toc blg bbl bbl.bak tex.bak out pyc pyg ttt; do
    if [ -f "$bn.$ext" ]; then
        rm "$bn.$ext"
    fi
done
