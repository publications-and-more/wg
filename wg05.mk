# File: wg05.mk
# Author: Amlal El Mahrouss
# Purpose: Generate HTML and PDF papers from LaTex documents.
# (C) 2025-2026 Amlal El Mahrouss.
# Licensed under Apache 2.0.


.PHONY: wg05
wg05: clean
	$(HTMLTEX) source/wg05/paper.tex
	$(PDFTEX) source/wg05/paper.tex
	$(HTMLTEX) source/wg05/articles/article.tex
	$(PDFTEX) source/wg05/articles/article.tex

