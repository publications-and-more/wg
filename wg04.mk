# File: wg04.tex
# Author: Amlal El Mahrouss
# Purpose: Generate HTML and PDF papers from LaTex documents.
# (C) 2026 Amlal El Mahrouss.
# Licensed under Apache 2.0.

.PHONY: wg04
wg04: clean
	$(HTMLTEX) source/wg04/sketch-01.tex
	$(PDFTEX) source/wg04/sketch-01.tex
	$(HTMLTEX) source/wg04/paper.tex
	$(PDFTEX) source/wg04/paper.tex

