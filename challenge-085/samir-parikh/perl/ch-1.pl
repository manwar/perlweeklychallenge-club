#!/usr/local/bin/perl

use warnings;
use strict;
use feature 'say';
use Algorithm::Combinatorics qw/combinations permutations/;
use List::Util qw/sum/;

# run program as:
# $ ./ch-1.pl "0.5, 1.1, 0.3, 0.7"
my @data = split /, /, $ARGV[0];
my $citer = combinations(\@data, 3);
my $notFound = 1;

while (my $c = $citer->next) {
    if (sum(@$c) > 1 && sum(@$c) < 2) {
        say "found triplet such that 1 < ", join( " + ", @$c), " < 2";
        $notFound = 0;
    }
}

say "no triplets found such that 1 < a+b+c < 2" if $notFound;
