#! /usr/bin/raku

use Test;

plan 5;

is-deeply(dyckwords(1), ['UD'], 'example 1');
is-deeply(dyckwords(2), ['UDUD', 'UUDD'], 'example 2');
is-deeply(dyckwords(3), ['UDUDUD', 'UDUUDD', 'UUDDUD', 'UUDUDD', 'UUUDDD'], 'example 3');
is-deeply(dyckwords(0), [''], 'example 4');
is-deeply(dyckwords(4), ['UDUDUDUD', 'UDUDUUDD', 'UDUUDDUD', 'UDUUDUDD', 'UDUUUDDD', 'UUDDUDUD', 'UUDDUUDD', 'UUDUDDUD', 'UUDUDUDD', 'UUDUUDDD', 'UUUDDDUD', 'UUUDDUDD', 'UUUDUDDD', 'UUUUDDDD'], 'example 5');

sub dyckwords($order) {
    my @out;
    my @queue = ("",);
    while (@queue.elems > 0) {
        my $st = @queue.shift;
        my $dcount = $st.comb.grep(/D/).elems;
        if ($st.chars == $order * 2) {
            if ($dcount == $order) {
                @out.push($st);
            }
        } else {
            if ($dcount * 2 < $st.chars) {
                @queue.push($st ~ 'D');
            }
            @queue.push($st ~ 'U');
        }
    }
    @out;
}
