# File: Makefile
# Author: Amlal El Mahrouss
# Purpose: Generate HTML papers from LaTex documents.

all: html-wg01 html-wg02
	@echo "=> DONE.

.PHONY: html-wg01
html-wg01:
	htlatex source/wg01/wg01.tex

.PHONY: html-wg02
html-wg02:
	htlatex source/wg02/wg02.tex
