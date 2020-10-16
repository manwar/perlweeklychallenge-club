#!/usr/bin/env raku

sub interleaved($a is rw, $b is rw, $c is rw) {
    ($a, $b) .= reverse if $a.chars < $b.chars;
    my ($has-a, $has-b) = False, False;
    $c ~~ s/ $a {$has-a = True} | $b {$has-b = True} // for ^2;
    +($c eq ｢｣ && ($has-a && $has-b || $a eq $b))
}

say interleaved |@*ARGS;
