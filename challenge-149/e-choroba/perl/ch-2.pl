#!/usr/bin/perl
use warnings;
use strict;

use Math::Base::Convert qw{ cnv };

my @digits36 = (0 .. 9, 'A' .. 'Z');
sub largest_square {
    my ($base) = @_;
    die "Base can't be more than 36.\n" if $base > 36;

    my $chars = [@digits36[0 .. $base - 1]];
    my $start = join "", reverse @$chars;
    my $n = int sqrt cnv($start, $chars, 10);

    while ($n) {
        my $square = cnv($n * $n, 10, $chars);

        --$n, next if $square =~ /(.).*\1/;

        return $square
    }
}

use Test::More tests => 5;

is largest_square(2), '1';
is largest_square(4), '3201';
is largest_square(10), '9814072356';
is largest_square(12), 'B8750A649321';
is largest_square(16), 'FED5B39A42706C81';
