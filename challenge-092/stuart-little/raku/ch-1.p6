#!/usr/bin/env perl6
use v6;

# run as <script> <two space-separated words>

sub isop($str1,$str2) { ($str1.chars == $str2.chars) && (($str1.comb Z=> $str2.comb).unique == $str1.comb.unique == ($str2.comb Z=> $str1.comb).unique == $str2.comb.unique) }

say isop(|@*ARGS).Int
