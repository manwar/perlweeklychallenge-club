#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    { in  => "aaaaa77777",         out => -1 },
    { in  => "abcde",              out => -1 },
    { in  => "9zero8eight7seven9", out => 8  },
    { in  => "xyz9876543210",      out => 8  },
    { in  => "4abc4def2ghi8jkl2",  out => 4  },
);

is second_largest_digit($_->{in}), $_->{out} foreach @examples;

done_testing;

sub second_largest_digit {
    my ($str) = @_;

    my @digits = $str =~ /\d/g;
    my %unique;
    $unique{$_} = 1 for @digits;
    my @sorted_digits = sort { $b <=> $a } keys %unique;

    return (@sorted_digits < 2)?(-1):($sorted_digits[1]);
}
