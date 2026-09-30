#!/usr/bin/env raku

use Test;

my @examples = (
    %{ in => 20, out => 12 },
    %{ in => 7,  out => 2  },
    %{ in => 1,  out => 0  },
    %{ in => 15, out => 8  },
    %{ in => 30, out => 22 },
);

is count-pythagorean-triplets($_{<in>}), $_{<out>} for @examples;

done-testing;

sub count-pythagorean-triplets(Int $n) {
    my $count = 0;
    for 1 .. $n -> $a {
        for 1 .. $n -> $b {
            my $c = sqrt($a*$a + $b*$b);
            $count++ if $c <= $n && $c == $c.Int;
        }
    }
    return $count;
}
