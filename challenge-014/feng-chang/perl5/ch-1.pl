#!/bin/env perl

use Modern::Perl;

my @eck = (0, 0);

exit unless defined $ARGV[0];
my $n = int($ARGV[0]);
exit if $n < 2;

for my $i (2 .. $n) {
    $eck[$i] = 0;

    for (my $j = $i - 2; $j >= 0; --$j) {
        if ($eck[$j] == $eck[$i - 1]) {
            $eck[$i] = $i - $j - 1;
            last;
        }
    }
}

say join(' ', @eck);
