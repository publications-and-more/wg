# File: wg03.tex
# Author: Amlal El Mahrouss
# Purpose: Generate HTML and PDF papers from LaTex documents.
# (C) 2025-2026 Amlal El Mahrouss.
# Licensed under Apache 2.0.

.PHONY: wg03
wg03:
	$(HTMLTEX) source/wg03/paper.tex
	$(PDFTEX) source/wg03/paper.tex

