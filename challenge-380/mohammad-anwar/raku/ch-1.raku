#!/usr/bin/env raku

use Test;

my @examples = (
    { in => "banana",   out => 5 },
    { in => "teestett", out => 7 },
    { in => "aeiouuaa", out => 3 },
    { in => "rhythm",   out => 2 },
    { in => "x",        out => 1 },
);

for @examples -> $ex {
    is sum-of-freq($ex<in>), $ex<out>;
}

done-testing;

sub sum-of-freq($str) {
    my (%v, %c);

    for $str.lc.comb -> $char {
        if    $char ~~ /<[aeiou]>/ { %v{$char}++ }
        elsif $char ~~ /<[a..z]>/  { %c{$char}++ }
    }

    my $max_v = %v ?? %v.values.max !! 0;
    my $max_c = %c ?? %c.values.max !! 0;

    return $max_v + $max_c;
}
