SHELL := /usr/bin/env bash
TARGETS = $(patsubst %.tex, %.pdf, $(wildcard [a-zA-Z0-9_-]*.tex))

all: $(TARGETS)

%.pdf: %.tex
	pdflatex --shell-escape $< -o $@
	pdflatex --shell-escape $< -o $@

clean:
	rm -f [a-zA-Z0-9_-]*.{aux,log,nav,out,snm,toc,vrb}
	rm -rf _minted-[a-zA-Z0-9_-]*/

purge: clean
	rm -f [a-zA-Z0-9_-]*.pdf
