# Build all five decks with: latexmk   (one deck: latexmk 2_git.tex)
# Clean up build files with: latexmk -c
$clean_ext = 'nav snm vrb';   # beamer files latexmk does not know about
$pdf_mode = 1;
@default_files = ('1_command_line_basics.tex', '2_git.tex', '3_package_management.tex', '4_hpc.tex', '5_pipelines.tex');
$pdflatex = 'pdflatex -interaction=nonstopmode -halt-on-error -file-line-error %O %S';

# Diagrams: images/diagrams/<name>.drawio -> <name>.pdf
# latexmk exports a diagram when its PDF is missing or the .drawio has changed.
# Needs the drawio desktop app. Edit the .drawio files in drawio, then run latexmk.
add_cus_dep('drawio', 'pdf', 0, 'drawio2pdf');
sub drawio2pdf {
    return system("drawio --export --format pdf --crop --output '$_[0].pdf' '$_[0].drawio' >/dev/null 2>&1");
}
