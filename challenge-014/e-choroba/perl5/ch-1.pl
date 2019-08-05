#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

sub van_eck {
    my %latest;
    my ($n, $a_n) = (0, 0);
    return sub {
        my $r = $a_n;
        my $a_n_plus_1 = exists $latest{$a_n}
            ? $n - $latest{$a_n}
            : 0;
        $latest{$a_n} = $n++;
        $a_n = $a_n_plus_1;
        return $r
    }
}

use Test::More;

my $iterator = van_eck();

is_deeply([map $iterator->(), 1 .. 19],
           [0, 0, 1, 0, 2, 0, 2, 2, 1, 6, 0, 5, 0, 2, 6, 5, 4, 0, 5]);

done_testing();
