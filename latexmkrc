# Build the slides with: latexmk
# Clean up build files with: latexmk -c
$pdf_mode = 1;
@default_files = ('main.tex');
$pdflatex = 'pdflatex -interaction=nonstopmode -halt-on-error -file-line-error %O %S';
