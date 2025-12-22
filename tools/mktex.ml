(*
        File: mktex.ml
        Purpose: Builds a paper template for LaTeX.
	Copyright 2025, Amlal El Mahrouss & NeKernel.org Authors.
	Licensed under Apache 2.0.
*)

open Stdlib
open Printf
open Out_channel

let title_index : int = 2
let file_index : int = 1
let format = format_of_string "
\\documentclass[11pt, a4paper]{article}
\\usepackage{graphicx}
\\usepackage{listings}
\\usepackage{xcolor}
\\usepackage{hyperref}
\\usepackage[margin=0.5in,top=1in,bottom=1in]{geometry}

\\title{%s}
\\author{John Doe.\\\\example@nekernel.org}
\\date{\\today}

\\begin{document}
\\bf
\\maketitle
\\begin{center}
	\\rule[1cm]{17cm}{0.01cm}
\\end{center}
\\end{document}
";;

let () = if Array.length Sys.argv >= 3 then
  let out_file : string = Sys.argv.(file_index)^".tex" in
    let file : out_channel = open_text out_file in
      fprintf file format Sys.argv.(title_index);
    close_out file;
  else
    printf "mktex - build LaTeX documents.\n";
    printf "usage: <file_name> <document_title>\n";

