#!/usr/bin/env perl
# Perl weekly challenge 187
# Task 2:  Magical Triplets
#
# See https://wlmb.github.io/2022/10/17/PWC187/#task-2-magical-triplets
use v5.36;
use Algorithm::Combinatorics qw(combinations);
use List::Util qw(first);
die <<FIN unless @ARGV;
Usage: $0 N1 N2 N3 [N4...]
to find the maximum ordered triplet with elements from {N1, N2...} that obeys
the strict triangle inequalities.
FIN
my @set = sort {$b<=>$a} @ARGV;
die "All numbers should be positive" unless $set[-1]>0;
my $iterator=combinations(\@set, 3);
while(my $triplet=$iterator->next){
    die "Expected ordered triplet: $triplet" # Currently uneeded
        unless $triplet->[0]>=$triplet->[1]>=$triplet->[2];
    next unless $triplet->[1]+$triplet->[2]>$triplet->[0];
    say "Input: (", join(", ", @ARGV), ") Output: (", join(", ", @$triplet), ")";
    exit;
}
say "Input: (", join(", ", @ARGV), ") Output: ()";
