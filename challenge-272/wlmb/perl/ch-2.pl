#!/usr/bin/env perl
# Perl weekly challenge 272
# Task 2:  String Score
#
# See https://wlmb.github.io/2024/06/03/PWC272/#task-2-string-score
use v5.36;
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to find the score of the strings S1 S2...
    i.e., the sum of the absolute value of
    the difference of consecutive ascii values.
    FIN
for(@ARGV){
    my $ords=pdl map {ord} split "";
    warn "Need at least two characters: $_", next unless $ords->nelem > 1;
    say "$_ -> ",($ords(1:-1)-$ords(0:-2))->abs->sumover;
}
