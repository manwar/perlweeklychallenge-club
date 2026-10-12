#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in => ["1+1i", "1+1i"        ], out => "0+2i"      },
    { in => ["1+(-1)i", "1+(-1)i"  ], out => "0+(-2)i"   },
    { in => ["0+3i", "0+4i"        ], out => "-12+0i"    },
    { in => ["3+4i", "3+(-4)i"     ], out => "25+0i"     },
    { in => ["50+(-20)i", "-10+30i"], out => "100+1700i" },
);

is complex_multiply(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub complex_multiply($x, $y) {
    my ($a, $b) = $x =~ /(-?\d+)\+?\(?(-?\d+)\)?i/;
    my ($c, $d) = $y =~ /(-?\d+)\+?\(?(-?\d+)\)?i/;
    my ($r, $i) = ($a * $c - $b * $d, $a * $d + $b * $c);
    return "$r" . ($i < 0 ? "+($i)i" : "+${i}i");
}
