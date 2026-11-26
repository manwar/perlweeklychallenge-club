#!/usr/bin/env raku

use Test;

my @examples =
    { in => "1/2+3/2",        out => "2/1"   },
    { in => "-5/2-3/2",       out => "-4/1"  },
    { in => "5/3-5/3",        out => "0/1"   },
    { in => "10/10-1/10+2/5", out => "13/10" },
    { in => "1/6+1/6+1/6",    out => "1/2"   },
;

is fraction-calc($_<in>), $_<out> for @examples;

done-testing;

sub fraction-calc($expr) {
    my $sum = 0/1;
    $sum += .Rat for $expr ~~ m:g/<[+-]>?\d+\/\d+/;
    return "{$sum.numerator}/{$sum.denominator}";
}
