#!/usr/bin/env raku

use Test;

my @examples = (
    { in => ["123", "45", "6"],           out => 123  },
    { in => ["abc", "de", "fghi"],        out => 4    },
    { in => ["0012", "99", "a1b2c"],      out => 99   },
    { in => ["x", "10", "xyz", "007"],    out => 10   },
    { in => ["hello123", "2026", "perl"], out => 2026 },
);

is max-str-val(@($_{"in"})), $_{"out"} for @examples;

sub max-str-val(*@str) {
    my $max = 0;
    for @str -> $s {
        my $val = $s ~~ /^ \d+ $/ ?? +$s !! $s.chars;
        $max = $val if $val > $max;
    }
    return $max;
}

done-testing;
