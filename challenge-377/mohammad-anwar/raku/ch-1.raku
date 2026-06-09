#!/usr/bin/env raku

use Test;

my @examples = (
    { in  => "abcba",   out => "true"  },
    { in  => "racecar", out => "true"  },
    { in  => "abcd",    out => "false" },
    { in  => "banana",  out => "true"  },
    { in  => "hello",   out => "true"  },
);

is reverse-substr-exists($_<in>), $_<out> for @examples;

done-testing;

sub reverse-substr-exists($str) {
    my $rev = $str.flip;
    for 0 .. $str.chars - 2 -> $i {
        my $sub = $str.substr($i, 2);
        return "true" if $rev.index($sub).defined;
    }

    return "false";
}
