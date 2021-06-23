#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-118/ TASK #1

my $B = sprintf "%b", shift;
say (($B eq reverse($B)) ? 1 : 0);

__END__

./ch-1.pl 5
1
./ch-1.pl 15
1
./ch-1.pl 16
0
./ch-1.pl 73
1
./ch-1.pl 74
0
