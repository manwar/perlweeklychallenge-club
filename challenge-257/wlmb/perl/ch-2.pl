#!/usr/bin/env perl
# Perl weekly challenge 257
# Task 2:  Reduced Row Echelon
#
# See https://wlmb.github.io/2024/02/20/PWC257/#task-2-reduced-row-echelon
use v5.36;
use List::AllUtils qw(firstidx reduce all none);
die <<~"FIN" unless @ARGV;
    Usage: $0 R0 [R1...]
    where Rn is a space separated row of the form
    "Mn0 Mn1... Mnm"
    and Mij are numbers, the entries of a matrix M,
    to test if M is a reduced row echelon matrix
    FIN
# Read matrix
my @matrix;
push @matrix, map {[split " "]} @ARGV;
my @indices_first=map {firstidx {$_} @$_} @matrix; #indices of first non null element of each row
my $first_empty=firstidx {$_==-1}@indices_first;   # first row of zeroes
$first_empty=@indices_first if $first_empty==-1;   # none found
my $result=all{$indices_first[$_]==-1}$first_empty+1..@indices_first-1; # all zero rows at end
$result &&= all{$indices_first[$_] < $indices_first[$_+1]} 0..$first_empty-2; # to right of previous
$result&&=all{$matrix[$_][$indices_first[$_]]==1} 0..$first_empty-1;   #leading non zero are ones
for(0..$first_empty-1){
    my $j=$indices_first[$_];
    $result &&= none{$matrix[$_][$j]} (0..$_-1);   # check zeroes above first non-zero
}
say join "\n", "[", map({join " ", " [", @$_, "]"}@matrix), "]", "-> ", $result||0, "\n";
