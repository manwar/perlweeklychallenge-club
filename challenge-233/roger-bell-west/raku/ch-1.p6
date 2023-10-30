#! /usr/bin/raku

use Test;

plan 3;

is(similarwords(['aba', 'aabb', 'abcd', 'bac', 'aabc']), 2, 'example 1');
is(similarwords(['aabb', 'ab', 'ba']), 3, 'example 2');
is(similarwords(['nba', 'cba', 'dba']), 0, 'example 3');

sub similarwords(@a) {
    my %ct;
    my $ac = ord('a');
    for @a -> $w {
        my $hs = Set.new($w.comb);
        my $mask = 0;
        for $hs.keys -> $c {
            $mask +|= 1 +< (ord($c) - $ac);
        }
        %ct{$mask}++;
    }
    my $pairs = 0;
    for %ct.values -> $cv {
        if ($cv > 1) {
            $pairs += $cv * ($cv - 1) / 2;
        }
    }
    return $pairs;
}
