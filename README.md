# Command line and HPC workshop

Slides and exercises for a one-day, hands-on introduction to the command line, Git,
Conda and the UMC Utrecht HPC.

## For participants

- **Slides:** [main.pdf](main.pdf)
- **Exercises:** [exercises/](exercises/), one file per section, with [solutions](exercises/solutions/)
- **Data for the exercises:** [exercise_data/](exercise_data/)

Get everything on your laptop or the HPC:

```bash
cd ~                          # laptop: home
cd /hpc/<group>/<user>/data   # HPC: data directory, never your home
git clone https://github.com/bayraktar1/HPC_intro.git
cd HPC_intro/exercise_data
```

Then follow [exercises/README.md](exercises/README.md).

## Contents

```
HPC_intro/
├── main.pdf          # the slides
├── exercises/        # numbered exercises per section, and solutions/
├── exercise_data/    # small FASTA and FASTQ files used in the exercises
├── main.tex          # slide source: preamble, then one file per section
├── sections/         # cli.tex, git.tex, packages.tex, hpc.tex
└── images/           # photos (JPEG), logos and screenshots (PNG),
                      # diagrams/ (drawio sources, exported to PDF)
```

## Building the slides

Needs a TeX distribution with `latexmk` and `pdflatex`.

```bash
latexmk               # build main.pdf (settings in latexmkrc)
latexmk -c            # remove build files
chktex -l chktexrc main.tex sections/*.tex                 # check
latexindent -l -s -w -c=/tmp main.tex sections/*.tex       # format
```

Diagrams are edited in [drawio](https://www.drawio.com/) as `images/diagrams/*.drawio`.
`latexmk` exports a diagram to PDF when its `.drawio` file has changed; this needs the
drawio desktop app. The exported PDFs are committed, so building without drawio works.

The preamble in `main.tex` documents the helper commands used in the slides,
such as `\cmd{...}` for commands typed as-is and `\begin{exlist}` for exercise slides.

## Author

Doğukan Bayraktar
