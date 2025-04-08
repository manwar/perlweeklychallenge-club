#! /usr/bin/raku

use Test;

plan 3;

is(subsequence('uvw', 'bcudvew'), True, 'example 1');
is(subsequence('aec', 'abcde'), False, 'example 2');
is(subsequence('sip', 'javascript'), True, 'example 3');

sub subsequence($a, $b) {
    my $l = $a;
    my $s = $b;
    if ($a.chars < $b.chars) {
        $l = $b;
        $s = $a;
    }
    my @st = $s.comb;
    my $si = 0;
    for $l.comb -> $c {
        if ($c eq @st[$si]) {
            $si++;
            if ($si >= @st.elems) {
                return True;
            }
        }
    }
    False;
}
