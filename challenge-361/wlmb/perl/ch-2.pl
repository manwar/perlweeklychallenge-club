#!/usr/bin/env perl
# Perl weekly challenge 361
# Task 2:  Find Celebrity
#
# See https://wlmb.github.io/2026/02/16/PWC361/#task-2-find-celebrity
use v5.36;
use feature qw(try);
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV;
    Usage: $0 M0 M1...
    Find celebrities from within the guests of a party, described by their
    knowledge matrix Mn, where Mn_ij=1 if guest i knows guest j. The input matrix
    is a string of the form "[[m00 m11...][m10 m11...]...[...]]" where
    the entries mij are ones or zeroes, so that it may be read by PDL.
    FIN
for(@ARGV){
    try {
        die "Only ones and zeroes allowed: $_"
            unless /^[][10\s,]*$/;
        my $matrix=pdl($_);
        my $id=identity($matrix);
        my $celebrities=
            (!(($matrix&!$id)->orover)
             & ($matrix|$id)->transpose->andover
            )->which;
        say "$matrix -> ", $celebrities->isempty? -1 :$celebrities((0));
    }
    catch($e){warn $e}
}
