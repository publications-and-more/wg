(*
  File: addentry.ml
  Purpose: Creates a makefile rule.
  Copyright 2026, Amlal El Mahrouss & NeKernel.org Authors.
  Licensed under Apache 2.0.
*)

open Stdlib
open Out_channel
open Printf

let paper_name_index : int = 2
let file_index : int = 1

let format = format_of_string
  "

.PHONY: %s
%s: clean
	$(HTMLTEX) source/%s/paper.tex
	$(PDFTEX) source/%s/paper.tex
"
;;

let () =
  if Array.length Sys.argv >= 3 then
    let out_file = Sys.argv.(file_index) ^ ".mk" in
    let file = open_text out_file in
    let name = Sys.argv.(paper_name_index) in

    fprintf file format name name name name;

    close_out file
  else (
    printf "addentry: Add paper Makefile entry.\n";
    printf "addentry: usage: <file_index> <paper_name_index>\n"
  )