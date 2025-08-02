#! /usr/bin/raku

use Test;

plan 3;

is(mergestrings('abcd', 1234), 'a1b2c3d4', 'example 1');
is(mergestrings('abc', 12345), 'a1b2c345', 'example 2');
is(mergestrings('abcde', 123), 'a1b2c3de', 'example 3');

sub mergestrings($a, $b) {
    my @aa = $a.comb;
    my @bb = $b.comb;
    my $out;
    for 0 .. max(@aa.end, @bb.end) -> $i {
        if ($i <= @aa.end) {
            $out ~= @aa[$i];
        }
        if ($i <= @bb.end) {
            $out ~= @bb[$i];
        }
    }
    return $out;
}
