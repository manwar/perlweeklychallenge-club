#!/usr/bin/env raku

use Test;

my @examples = (
    { in => [3,6,12],      out => [3,6,12]      },
    { in => [1,2,4,8],     out => [1,2,4,8]     },
    { in => [7,8,9,10],    out => [8,10,7,9]    },
    { in => [5,9,15,17],   out => [5,9,15,17]   },
    { in => [11,13,14,19], out => [14,13,11,19] },
);

for @examples {
    is-deeply sort-binary-reflection(|$_<in>), $_<out>;
}

done-testing;

sub sort-binary-reflection(*@arr) {
    my $ref = sub ($x) { :2($x.base(2).flip) };
    return [ @arr.sort({ $ref($^a) <=> $ref($^b) || $^a <=> $^b }) ];
}
