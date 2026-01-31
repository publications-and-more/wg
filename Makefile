# File: Makefile
# Author: Amlal El Mahrouss
# Purpose: Generate HTML and PDF papers from LaTex documents.
# (C) 2025-2026 Amlal El Mahrouss.
# Licensed under Apache 2.0.

PDFTEX ?= pdflatex
HTMLTEX ?= htlatex
ECHO := @echo

include wg01.mk
include wg02.mk
include wg03.mk

.PHONY: wg05
wg05:
	$(HTMLTEX) source/wg05/paper.tex
	$(PDFTEX) source/wg05/paper.tex
	$(HTMLTEX) source/wg05/tn001.05/paper.tex
	$(PDFTEX) source/wg05/tn001.05/paper.tex
