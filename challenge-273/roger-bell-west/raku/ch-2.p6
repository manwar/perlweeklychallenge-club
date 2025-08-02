#! /usr/bin/raku

use Test;

plan 4;

is(baftera('aabb'), True, 'example 1');
is(baftera('abab'), False, 'example 2');
is(baftera('aaa'), False, 'example 3');
is(baftera('bbb'), True, 'example 4');

sub baftera($a) {
    my $firstb = index($a, "b");
    if (!$firstb.defined) {
        return False;
    }
    my $lasta = rindex($a, "a");
    if (!$lasta.defined) {
        return True;
    }
    return $lasta < $firstb;
}
