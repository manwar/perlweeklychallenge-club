#!/usr/bin/env perl
# Perl weekly challenge 156
# Task 2: Weird number
#
# See https://wlmb.github.io/2022/03/14/PWC156/#task-2-weird-number
use v5.12;
use warnings;
use Math::Prime::Util qw(divisors);
use Algorithm::Combinatorics qw(subsets);
use List::Util qw(sum0);
die "Usage: ./ch-2.pl N1 N2... to test numbers N1, N2... for weirdness"
    unless @ARGV;
my $is_weird;
 WEIRD:
    for my $N(@ARGV){
        say("Arguments must be larger than 1"), next unless $N>=2;
        my @divisors=divisors($N);
        pop @divisors; # keep only proper divisors
        $is_weird=0, next WEIRD unless sum0(@divisors)>$N; # Overabundant?
        my @subsets=subsets(\@divisors);
        for(@subsets){
            $is_weird=0, next WEIRD if sum0(@$_)==$N; #Semiperfect, fail
        }
        $is_weird=1;
} continue {
    say "$N ", $is_weird?"is":"is not", " weird";
}
