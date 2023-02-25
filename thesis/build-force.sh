rm thesis.aux
latexmk -synctex=1 -shell-escape -pdf thesis.tex
make -j 8 -f thesis.makefile
latexmk -synctex=1 -shell-escape -g -pdf thesis.tex
