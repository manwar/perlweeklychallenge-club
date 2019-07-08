#!/usr/bin/env perl6

 put ([\+] (1 .. 100)).grep(* < 100)[*-1]:k + 1;
