#!/usr/bin/env perl
# Perl weekly challenge 303
# Task 2:  Delete and Earn
#
# See https://wlmb.github.io/2025/01/06/PWC303/#task-2-delete-and-earn
use v5.36;
use List::UtilsBy qw(max_by);

die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    for computing the maximum earnings one can obtain by choosing
    a number n from the set {N1, N2...}, earning its points and
    deleting it and all instances of of n+1 and n-1, and repeating
    until no numbers remain
    FIN

my %freq; # hash of frequencies
$freq{$_}++ for @ARGV; # count appearances of each number

my $total = 0;
while(my @keys=keys %freq){
    # maximize the gain after subtracting the loss of potential gains.
    my $choice = max_by {gain($_) - gain($_+1) - gain($_-1)} @keys;
    $total += gain($choice);
    delete $freq{$_} for ($choice-1..$choice+1);
}

say "@ARGV -> $total";

sub gain($x){ # gain from choosing all the numbers $x
    $x*($freq{$x}//0);
}
