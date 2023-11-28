#!/usr/bin/env perl
# Perl weekly challenge 245
# Task 1:  Sort Language
#
# See https://wlmb.github.io/2023/11/27/PWC245/#task-1-sort-language
use v5.36;
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 L1 P1 [L2 P2...]
    to sort the space separated list of languages Ln
    according to their popularity Pn
    FIN
while(@ARGV){
    my @language=split " ", shift;
    my @popularity=split " ", shift;
    warn("Number of elements should coincide: languages: @language vs. popularities @popularity\n"),
	next unless @language==@popularity;
    my @sorted=map {$language[$_]} sort {$popularity[$a]<=>$popularity[$b]} 0..@language-1;
    say "languages: @language\npopularities: @popularity\nsorted: @sorted\n";
}
