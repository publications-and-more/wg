(*
  File: addpaper.ml
  Purpose: Creates a paper template in LaTeX.
  Copyright 2025-2026, Amlal El Mahrouss & NeKernel.org Authors.
  Licensed under Apache 2.0.
*)

open Stdlib
open Out_channel
open Printf

let author_index : int = 3
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
\\author{%s.\\\\john@nekernel.org}
\\date{\\today}

\\begin{document}
\\bf
\\maketitle
\\begin{center}
	\\rule[0.01cm]{17cm}{0.01cm}
\\end{center}
\\abstract{}
\\begin{center}
	\\rule[0.01cm]{17cm}{0.01cm}
\\end{center}
\\end{document}
";;

(*
  We just make a LaTeX file with the given title.
*)
let () = if Array.length Sys.argv >= 4 then
  let out_file : string = Sys.argv.(file_index)^".tex" in
    let file : out_channel = open_text out_file in
      fprintf file format Sys.argv.(title_index);
      fprintf file format Sys.argv.(author_index);
    close_out file;
  else (
    printf "addpaper: Creates LaTeX papers.\n";
    printf "addpaper: usage: <file_name> <document_title>\n"
  );
