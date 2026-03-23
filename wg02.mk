# File: wg02.mk
# Author: Amlal El Mahrouss
# Purpose: Generate HTML and PDF papers from LaTex documents.
# (C) 2025-2026 Amlal El Mahrouss.
# Licensed under Apache 2.0.

.PHONY: wg02
wg02: clean
	$(HTMLTEX) source/wg02/paper.tex
	$(PDFTEX) source/wg02/paper.tex

