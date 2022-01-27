#!/usr/bin/perl
use warnings;
use strict;

use Math::Int2Base qw{ int2base base2int };

sub largest_square {
    my ($base) = @_;
    die "Base can't be more than 36.\n" if $base > 36;

    my $start = join "", map int2base($_, 36), reverse 0 .. $base - 1;
    my $n = int sqrt base2int($start, $base);
    if ($n =~ /E/) {
        use bigint;
        $n = int sqrt base2int($start, $base);
    }

    while ($n) {
        my $square = int2base($n * $n, $base);

        --$n, next if $square =~ /(.).*\1/;

        return $square
    }
}

use Test::More tests => 5;

is largest_square(2), '1';
is largest_square(4), '3201';
is largest_square(10), '9814072356';
is largest_square(12), 'B8750A649321';
is largest_square(16), 'FEB6795D4C32A801';
