#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw/ min /;
use Test::More;

my @ints_1 = (1, 5, 0, 3, 5);
my @ints_2 = (0);
my @ints_3 = (2, 1, 4, 0, 3);
cmp_ok( min_zero_ops( @ints_1 ), '==', 3, "Example 1" );
cmp_ok( min_zero_ops( @ints_2 ), '==', 0, "Example 2" );
cmp_ok( min_zero_ops( @ints_3 ), '==', 4, "Example 3" );
done_testing();

sub min_zero_ops {
    my @i = @_;
    my $smallest;
    my @non_zero;
    my $operations = 0;
    for (0 .. (scalar @i -1 )) {
        if ( $i[$_] != 0  ) {
            push @non_zero, $_;
        }
    }
    while ( @non_zero != 0 ) {
        $smallest = min( @i[ @non_zero ]);
        for (@non_zero) {
            $i[$_] -= $smallest;
        }
        @non_zero = grep { $i[$_] > 0 } @non_zero;
        $operations++;
    }
    return $operations;
}

