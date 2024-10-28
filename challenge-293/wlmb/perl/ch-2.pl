#!/usr/bin/env perl
# Perl weekly challenge 293
# Task 2:  Boomerang
#
# See https://wlmb.github.io/2024/10/28/PWC293/#task-2-boomerang
use v5.36;
use PDL;
use PDL::NiceSlice;

die <<~"FIN" unless @ARGV;
    Usage: $0 M1 M2...
    to check if the three 2D row vectors forming each matrix M1 M2...
    form a boomerang. The matrices should be strings in the format "[[x0 y0][x1 y1][x2 y2]]"
    with xi, yi numbers.
    FIN

for(@ARGV){
    my $matrix=pdl($_);
    say("Wrong format $m->info: $_"), next unless $m->dim(0)==2 && $->dim(1)==3;
    my $first=$matrix(:,(0));
    my $rest=$matrix(:,1:-1);
    $rest -= $first; # Translate first vector to origin
    my $determinant = $rest->det;
    my $result = $determinant != 0? "True" : "False";
    say "$_ -> $result";
}
