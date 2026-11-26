#!/usr/bin/env perl

use v5.38;
use Test::More;
use Math::BigRat;

my @examples = (
    { in => "1/2+3/2",        out => "2/1"   },
    { in => "-5/2-3/2",       out => "-4/1"  },
    { in => "5/3-5/3",        out => "0/1"   },
    { in => "10/10-1/10+2/5", out => "13/10" },
    { in => "1/6+1/6+1/6",    out => "1/2"   },
);

is fraction_calc($_->{in}), $_->{out} foreach @examples;

done_testing;

sub fraction_calc($expr) {
    my $sum = Math::BigRat->new('0/1');
    $sum += Math::BigRat->new($_) for $expr =~ /[+-]?\d+\/\d+/g;
    return $sum->numerator . '/' . $sum->denominator;
}
