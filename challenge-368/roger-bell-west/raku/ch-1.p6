#! /usr/bin/raku

use Test;

plan 5;

is(makeitbigger('15456', '5'), '1546', 'example 1');
is(makeitbigger('7332', '3'), '732', 'example 2');
is(makeitbigger('2231', '2'), '231', 'example 3');
is(makeitbigger('543251', '5'), '54321', 'example 4');
is(makeitbigger('1921', '1'), '921', 'example 5');

sub makeitbigger($st, $ch) {
    my $i = -1;
    my @nv;
    loop {
        with $st.index($ch, $i + 1) -> $c {
            my $o = $st;
            $o.substr-rw($c, 1) = "";
            @nv.push(0 + $o);
            $i = $c;
        } else {
            last;
        }
    }
    @nv.max();
}
