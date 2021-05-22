#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

#
# For a description of the algorithm, and the proof why this is correct:
# https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-113-1.html 
#

my @gcds = (0, 1, 2, 1, 2, 5, 2, 1, 2, 1);

MAIN: while (<>) {
    my ($N, $D) = split;
    if ($D == 0) {
        say $N >= 100 || $N % 10 == 0 ? 1 : 0;
        next MAIN;
    }
    if ($N >= $D * 10) {
        say  1;
        next MAIN;
    }
    for (my $i = 0; $i < $D / $gcds [$D]; $i ++) {
        my $T = $N - 10 * $i - $D;
        if ($T >= 0 && $T % $D == 0) {
            say  1;
            next MAIN;
        }
    }
    say 0;
}
