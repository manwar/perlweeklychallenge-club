#!/usr/bin/env raku

use Test;

my @examples = (
    { in => ["AAAAA",     2], out => 5 },
    { in => ["ABCDE",     4], out => 5 },
    { in => ["AAABBBBAA", 1], out => 5 },
    { in => ["ABACADA",   2], out => 5 },
    { in => ["BAAABAAAA", 1], out => 8 },
);

is character-replacement(|$_<in>), $_<out> for @examples;

done-testing;

sub character-replacement($str, $k) {
    my @s = $str.comb;
    my %c;
    my $l     = 0;
    my $max_f = 0;

    for 0 .. @s.end -> $r {
        my $char = @s[$r];
        %c{$char}++;
        $max_f = %c{$char} > $max_f ?? %c{$char} !! $max_f;
        if ($r - $l + 1) - $max_f > $k {
            %c{@s[$l]}--;
            $l++;
        }
    }
    return @s.elems - $l;
}
