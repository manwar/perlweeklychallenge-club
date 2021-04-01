#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

is(max_gap(2, 9, 3, 5), 4);
is(max_gap(1, 3, 8, 2, 0), 5);
is(max_gap(5), 0);

done_testing;

sub max_gap {
    my @n = @_;

    return 0 if @n == 1;

    my $x;
    my $d = 0;
    foreach (reverse sort @n) {
        $x = $_ and next unless defined $x;
        $d = $x - $_ if ($d < $x - $_);
        $x = $_;
    }

    return $d;
}
