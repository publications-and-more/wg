# File: Makefile
# Author: Amlal El Mahrouss
# Purpose: Compile Coq proofs for WG05 to the Coq kernel.
# (C) 2026 Amlal El Mahrouss.
# Licensed under Apache 2.0.

COQMAKEFILE ?= Makefile.coq

all: $(COQMAKEFILE)
	$(MAKE) -f $(COQMAKEFILE)

$(COQMAKEFILE): _CoqProject
	coq_makefile -f _CoqProject -o $(COQMAKEFILE)

clean: $(COQMAKEFILE)
	$(MAKE) -f $(COQMAKEFILE) clean
	rm -f $(COQMAKEFILE) $(COQMAKEFILE).conf

.PHONY: all clean
