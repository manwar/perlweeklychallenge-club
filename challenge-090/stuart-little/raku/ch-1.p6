#!/usr/bin/env perl6
use v6;

# run as <script> <nucleobase sequence>

say "Length: ", @*ARGS[0].chars;
say "Complementary sequence: ", @*ARGS[0].uc.trans('ATCG'=>'TAGC');
