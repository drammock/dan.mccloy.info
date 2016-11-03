#! /bin/bash
xelatex -shell-escape $1
bibtex8 $(basename $1 .tex)
mv McCloy_CV.bbl McCloy_CV.bbl.bak
python boldify-my-name.py
xelatex -shell-escape $1
xelatex -shell-escape $1
xelatex -shell-escape $1
bn=$(basename $1 .tex)
for ext in .aux .ent .fff .log .lof .lol .lot .toc .blg .bbl .out .pyg .ttt; do
    if [ -f "$bn$ext" ]; then
        rm "$bn$ext"
    fi
done
