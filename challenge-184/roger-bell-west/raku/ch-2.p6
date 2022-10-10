#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(splitarray(["a 1 2 b 0", "3 c 4 d"]),
          [ [[1, 2, 0], [3, 4]],
            [['a', 'b'], ['c', 'd']] ],
          'example 1');

is-deeply(splitarray(["1 2", "p q r", "s 3", "4 5 t"]),
          [ [[1, 2], [3], [4, 5]],
            [['p', 'q', 'r'], ['s'], ['t']] ],
          'example 2');

sub splitarray(@list) {
    my @out = [ [], [] ];
    for @list -> $ins {
        my @av;
        my @bv;
        for $ins.comb -> $c {
            if ($c ge '0' && $c le '9') {
                @av.push(0 + $c);
            } elsif ($c ge 'a' && $c le 'z') {
                @bv.push($c);
            }
        }
        if (@av.elems > 0) {
            @out[0].push(@av);
        }
        if (@bv.elems > 0) {
            @out[1].push(@bv);
        }
    }
    return @out;
}
