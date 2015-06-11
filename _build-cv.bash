#! /bin/bash
cd _pandoc/
pandoc --from=markdown-auto_identifiers --natbib --no-tex-ligatures --template=cv-template.tex --output=cv.tex ../_cv-edit-this-one.markdown
python pandoc-latex-postprocessor.py
python convert-pandoc-refs-to-liquid.py
sh compile.bash McCloy_CV.tex
mv McCloy_CV.pdf ../
rm *.pyc
rm cv.tex
rm McCloy_CV.*
cd ../
