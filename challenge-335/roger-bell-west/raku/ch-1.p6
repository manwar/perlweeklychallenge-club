#! /usr/bin/raku

use Test;

plan 5;

is-deeply(commoncharacters(['bella', 'label', 'roller']), ['e', 'l', 'l'], 'example 1');
is-deeply(commoncharacters(['cool', 'lock', 'cook']), ['c', 'o'], 'example 2');
is-deeply(commoncharacters(['hello', 'world', 'pole']), ['l', 'o'], 'example 3');
is-deeply(commoncharacters(['abc', 'def', 'ghi']), [], 'example 4');
is-deeply(commoncharacters(['aab', 'aac', 'aaa']), ['a', 'a'], 'example 5');

sub commoncharacters(@a) {
    my %mc;
    my $first = True;
    for @a -> $s {
        my %mk;
        $s.comb("").map({%mk{$_}++});
        if ($first) {
            %mc = %mk;
            $first = False;
        } else {
            for %mc.keys -> $k {
                if (%mk{$k}:exists) {
                    %mc{$k} = [%mc{$k}, %mk{$k}].min;
                } else {
                    %mc{$k}:delete;
                }
            }
        }
    }
    my @out;
    for %mc.keys.sort -> $c {
        for 1 .. %mc{$c} {
            @out.push($c);
        }
    }
    @out;
}
