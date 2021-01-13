#!/usr/bin/env perl
#
# ch-1.pl - 3 Sum
#
# 2020 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

sub sum3 {
    my $T = shift;
    # Pre-build hash of numbers greater than $y for O(1) lookups in inner loop
    my @a = @_; my %Lh = map { shift @a => { map { $_ => 1 } @a } } 1..$#a;

    my @r;
    while (my $x = shift) {
        $Lh{$_}{ $T-$x-$_ } and push @r, [$x, $_, $T-$x-$_] for @_;
    }
    @r;
}

use Test::More;

is_deeply [sum3( -2 => -4, -1, 0, 3, 4 )], [[-4, -1, 3]];
is_deeply [sum3( -1 => -6, -5, 0, 5 )], [[-6, 0, 5]];
is_deeply [sum3( 0 => -6, -1, 0, 1, 2 )], [[-1, 0, 1]];
is_deeply [sum3( 2 => -8, -5, -2, 3, 4, 5 )], [[-5, 3, 4]];
is_deeply [sum3( -3 => -7, -6, -5, 0, 5, 6, 8 )], [[-6, -5, 8]];
is_deeply [sum3( 0 => -10, -9, -5, -4, -2, -1, 1, 5 )], [[-4, -1, 5]];
is_deeply [sum3( -6 => -19, -13, -11, -9, -2, -1, 0, 1, 3, 7, 8, 9, 10, 11, 14, 16 )], [
  [-19, -1, 14], [-19, 3, 10], [-13, -9, 16], [-13, -2, 9], [-13, -1, 8],
  [-13, 0, 7], [-11, -9, 14], [-11, -2, 7], [-9, 0, 3],
];

done_testing;
