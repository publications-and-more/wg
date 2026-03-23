# File: wg06.mk
# Author: Amlal El Mahrouss
# Purpose: Generate HTML and PDF papers from LaTex documents.
# (C) 2025-2026 Amlal El Mahrouss.
# Licensed under Apache 2.0.


.PHONY: wg06
wg06: clean
	$(HTMLTEX) source/wg06/articles/article.tex
	$(PDFTEX) source/wg06/articles/article.tex
