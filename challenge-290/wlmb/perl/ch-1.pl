#!/usr/bin/env perl
# Perl weekly challenge 290
# Task 1:  Double Exist
#
# See https://wlmb.github.io/2024/10/07/PWC290/#task-1-double-exist
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to find if a double exist in the secuence N1 N2...
    FIN
my @sorted = my @doubles = sort {$a<=>$b} @ARGV;
my $candidate = shift @doubles;
my $output = "false";
for(@sorted){
    last unless defined $candidate;
    $output = "true",last if $candidate == 2*$_;
    next if $candidate > 2*$_;
    $candidate=shift @doubles;
    redo;
}
say "@ARGV -> $output"
