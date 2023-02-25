# From https://tex.stackexchange.com/a/145878
rm thesis.aux
latexmk -synctex=1 -shell-escape -pdf thesis.tex
make -n -f thesis.makefile > /dev/null | grep pdflatex > /dev/null
if [ $? -eq 0 ] ; then
    make -j 8 -f thesis.makefile
    latexmk -synctex=1 -shell-escape -g -pdf thesis.tex
fi
