#!/usr/bin/env raku

sub interleaved($a, $b, $c is rw) {
    my ($is_a, $is_b) = 0, 0;
    $c ~~ s/($a)|$b/{ $0 and ++$is_a or ++$is_b; ｢｣ }/ for ^2;
    +($c eq ｢｣ && $is_a && $is_b)
}

say interleaved |@*ARGS;
