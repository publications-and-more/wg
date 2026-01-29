(*
  File: addrule.ml
  Purpose: Creates a makefile rule.
  Copyright 2026, Amlal El Mahrouss & NeKernel.org Authors.
  Licensed under Apache 2.0.
*)

open Stdlib
open Out_channel
open Printf

(*
  We just make a LaTeX file with the given title.
*)
let () = if Array.length Sys.argv >= 3 then
  printf "We are done here.";
