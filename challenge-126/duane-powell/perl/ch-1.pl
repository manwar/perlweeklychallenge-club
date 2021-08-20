#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-126/ TASK #1

my $N = shift || 20;
my @N = (2 .. $N);
say join(',', ( grep ! /1/, @N)); 

__END__

./ch-1.pl 
2,3,4,5,6,7,8,9,20

./ch-1.pl 40
2,3,4,5,6,7,8,9,20,22,23,24,25,26,27,28,29,30,32,33,34,35,36,37,38,39,40
