# File: wg01.tex
# Author: Amlal El Mahrouss
# Purpose: Generate HTML and PDF papers from LaTex documents.
# (C) 2025-2026 Amlal El Mahrouss.
# Licensed under Apache 2.0.

.PHONY: wg01
wg01: clean
	$(HTMLTEX) source/wg01/paper.tex
	$(PDFTEX) source/wg01/paper.tex

