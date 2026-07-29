#!/usr/bin/env raku

use Test;

my @examples = (
    %{ in => [42,         2], out => "101010" },
    %{ in => [15642094,  16], out => "EEADEE" },
    %{ in => [493,        8], out => "755"    },
    %{ in => [2228519,   36], out => "1BRJB"  },
    %{ in => [123456789, 64], out => "7MyqL"  },
);

is to-base(|$_{<in>}), $_{<out>} for @examples;

done-testing;

sub to-base($n, $b) {
    my @d = |('0'..'9'), |('A'..'Z'), |('a'..'z'), '+', '/';
    return $n ?? to-base($n div $b, $b) ~ @d[$n % $b] !! '';
}
