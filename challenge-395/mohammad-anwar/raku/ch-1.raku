#!/usr/bin/env raku

use Test;

my @examples = (
    { in => ["1+1i", "1+1i"        ], out => "0+2i"      },
    { in => ["1+(-1)i", "1+(-1)i"  ], out => "0+(-2)i"   },
    { in => ["0+3i", "0+4i"        ], out => "-12+0i"    },
    { in => ["3+4i", "3+(-4)i"     ], out => "25+0i"     },
    { in => ["50+(-20)i", "-10+30i"], out => "100+1700i" },
);

for @examples -> $_ {
    is complex-multiply(|$_<in>), $_<out>;
}

done-testing;

sub complex-multiply($x, $y) {
    my ($a, $b) = extract_coeffs($x);
    my ($c, $d) = extract_coeffs($y);
    my ($r, $i) = ($a * $c - $b * $d, $a * $d + $b * $c);
    return "$r" ~ ($i < 0 ?? "+($i)i" !! "+{$i}i");
}

sub extract_coeffs($str) {
    $str ~~ m:P5/(-?\d+)\+?\(?(-?\d+)\)?i/;
    return ($/[0].Int, $/[1].Int);
}
