(*
        File: makepaper.ml
        Purpose: Builds a paper template for LaTeX.
*)

open Stdlib
open Printf
open Out_channel

let title_index = 1
let format = "
\\documentclass[11pt, a4paper]{article}
\\usepackage{graphicx}
\\usepackage{listings}
\\usepackage{xcolor}
\\usepackage{hyperref}
\\usepackage[margin=0.5in,top=1in,bottom=1in]{geometry}

\\title{WGx.}
\\author{John Doe.\\example@nekernel.org}
\\date{\\today}"

(* Now format the document. *)
let () = if Array.length Sys.argv > 1 then
  let out_file : string = Sys.argv.(1)^".tex" in
    let file : out_channel = open_text out_file in
      fprintf file "%s" format;
    close_out file;

