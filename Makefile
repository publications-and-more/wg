# File: Makefile
# Author: Amlal El Mahrouss
# Purpose: Generate HTML and PDF papers from LaTex documents.

PDFTEX ?= pdflatex
HTTEX ?= htlatex
# That one should exist honestly.
ECHO := @echo

.PHONY: all
all: html-wg05 html-wg01 html-wg02
	$(ECHO) "=> Done building Tex files."

.PHONY: html-wg05
html-wg05:
	$(HTTEX) source/wg05/wg05.tex
	$(PDFTEX) source/wg05/wg05.tex

.PHONY: html-wg01
html-wg01:
	$(HTTEX) source/wg01/wg01.tex
	$(PDFTEX) source/wg01/wg01.tex

.PHONY: html-wg02
html-wg02:
	$(HTTEX) source/wg02/wg02.tex
	$(PDFTEX) source/wg02/wg02.tex


