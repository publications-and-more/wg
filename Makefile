# File: Makefile
# Author: Amlal El Mahrouss
# Purpose: Generate HTML papers from LaTex documents.

TEX := htlatex
ECHO := @echo

all: html-wg01 html-wg02
	$(ECHO) "=>  Done building Tex files."

.PHONY: html-wg01
html-wg01:
	$(TEX) source/wg01/wg01.tex

.PHONY: html-wg02
html-wg02:
	$(TEX) source/wg02/wg02.tex
