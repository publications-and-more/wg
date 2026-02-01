# File: Makefile
# Author: Amlal El Mahrouss
# Purpose: Generate HTML and PDF papers from LaTex documents.
# (C) 2025-2026 Amlal El Mahrouss.
# Licensed under Apache 2.0.

PDFTEX ?= pdflatex
HTMLTEX ?= htlatex
ECHO := @echo

.PHONY: all
all: clean
	ECHO "Cleanup is done."

.PHONY: clean
clean:
	@rm -rf *.4ct *.4tc *.aux *.css *.pdf *.html *.tmp *.dvi *.idv *.lg *.log *.xref *.out *.png

include wg01.mk
include wg02.mk
include wg03.mk
include wg05.mk