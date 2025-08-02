#!/usr/bin/env perl
# Perl weekly challenge 253
# Task 2:  Weakest Row
#
# See https://wlmb.github.io/2024/01/22/PWC253/#task-2-weakest-row
use v5.36;
use List::Util qw(all sum0);
die <<~"FIN" unless @ARGV;
    Usage: $0 R0 [R1...]
    to order the indices of the rows R_i of a binary matrix
    from weakest to strongest, where R_i is represented as
    a binary string.
    FIN
die "Only binary strings allowed" unless all {m/^[01]+$/} @ARGV;
my @matrix;
push @matrix, [split ""] for(@ARGV);
say format_matrix(@matrix), "\n-> ",
    join " ",
    map {$_->[0]}
    sort {$a->[1] <=> $b->[1] || $a->[0] <=> $b->[0]}
    map {[$_, sum0 $matrix[$_]->@*]}
    0..@matrix-1;
sub format_matrix(@m){
    return "[\n", (map {" [ @$_ ]\n"} @m), "]"
}
