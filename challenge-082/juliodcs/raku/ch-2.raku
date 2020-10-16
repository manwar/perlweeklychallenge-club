#!/usr/bin/env raku

sub interleaved($a is rw, $b is rw, $c is rw) {
    ($a, $b) .= reverse if $a.chars < $b.chars;
    my $found = 0;
    $c ~~ s/ $a | $b /{ $found++; ｢｣ }/ for ^2;
    +($c eq ｢｣ && ($found == 2 || $a eq $b))
}

say interleaved |@*ARGS;
