# File: wg04.mk
# Author: Amlal El Mahrouss
# Purpose: Generate HTML and PDF papers from LaTex documents.
# (C) 2026 Amlal El Mahrouss.
# Licensed under Apache 2.0.

.PHONY: wg04
wg04: clean
	$(HTMLTEX) source/wg04/paper.2.tex
	$(PDFTEX) source/wg04/paper.2.tex
	$(HTMLTEX) source/wg04/paper.tex
	$(PDFTEX) source/wg04/paper.tex

