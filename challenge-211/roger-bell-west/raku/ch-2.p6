#! /usr/bin/raku

use Test;

plan 3;

is(splitsameaverage([1, 2, 3, 4, 5, 6, 7, 8]), True, 'example 1');
is(splitsameaverage([1, 3]), False, 'example 2');
is(splitsameaverage([1, 2, 3]), True, 'example 3');

sub splitsameaverage(@a) {
    my $ss = @a.sum;
    my $ml = @a.elems;
    my $mx = floor($ml / 2);
    my $ssa = False;
    for 1 .. $mx -> $n {
        for @a.combinations($n) -> @c {
            my $ca = @c.sum;
            if (Rat.new($ca, $n) == Rat.new($ss - $ca, $ml - $n)) {
                $ssa = True;
                last;
            }
        }
        if ($ssa) {
            last;
        }
    }
    return $ssa;
}
