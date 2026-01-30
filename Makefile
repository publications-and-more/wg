# File: Makefile
# Author: Amlal El Mahrouss
# Purpose: Generate HTML and PDF papers from LaTex documents.
# (C) 2025-2026 Amlal El Mahrouss.
# Licensed under Apache 2.0.

PDFTEX ?= pdflatex
HTMLTEX ?= htlatex
ECHO := @echo

.PHONY: all
all: wg05 wg01 wg02 wg03
	$(ECHO) "=> Done building Tex files."

include wg01.mk
include wg02.mk
include wg03.mk

.PHONY: wg05
wg05:
	$(HTMLTEX) source/wg05/paper.tex
	$(PDFTEX) source/wg05/paper.tex
	$(HTMLTEX) source/wg05/tn001.05/paper.tex
	$(PDFTEX) source/wg05/tn001.05/paper.tex
