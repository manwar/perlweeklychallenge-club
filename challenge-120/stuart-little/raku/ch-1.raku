#!/usr/bin/env raku
use v6;

# run <script> <number>

say parse-base(sprintf("%08b", @*ARGS[0] +& 255).comb(2).map({.flip}).join(''),2)

