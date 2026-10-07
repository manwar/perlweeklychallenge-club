#!/usr/bin/env raku

use Test;

my @examples = (
    { in => "aAbB",   out => 0 },
    { in => "AAbb",   out => 1 },
    { in => "AAAbbb", out => 3 },
    { in => "aABb",   out => 1 },
    { in => "aBBAaa", out => 2 },
);

is min-swaps($_<in>), $_<out> for @examples;

done-testing;

sub min-swaps($str) {
    my @chars = $str.comb;
    my $calc  = sub ($start_lower) {
        my ($swaps, $target) = (0, 0);
        for 0 .. @chars.end -> $i {
            my $is_lower = @chars[$i] ~~ /<:Ll>/ ?? 1 !! 0;
            if $is_lower == $start_lower {
                $swaps  += abs($i - $target);
                $target += 2;
            }
        }
        return $swaps;
    };

    return min($calc(1), $calc(0));
}
