#! /usr/bin/raku

use Test;

plan 3;

is(semiorderedpermutation([2, 1, 4, 3]), 2, 'example 1');
is(semiorderedpermutation([2, 4, 1, 3]), 3, 'example 2');
is(semiorderedpermutation([1, 3, 2, 4, 5]), 0, 'example 3');

sub semiorderedpermutation(@a) {
    my $en = @a.elems;
    my $s = 1;
    my $e = $en - 1;
    for @a.kv -> $i, $n {
        if ($n == 1) {
            $s = $i;
        }
        if ($n == $en) {
            $e = $i;
        }
    }
    my $r = $s + ($en - 1 - $e);
    if ($s > $e) {
        $r--;
    }
    $r;
}
