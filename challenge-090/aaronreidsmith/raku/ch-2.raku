#!/usr/bin/env perl6

subset PositiveInt of Int where { $_ ~~ Int && $_ > 0 }

sub generate-pairs($a, $b) {
    sprintf("%02d, %02d", $a, $b).put;
    if $a == 1 {
        (($a, $b),);
    } else {
        (($a, $b), |generate-pairs($a div 2, $b * 2));
    }
}

sub MAIN(PositiveInt $A, PositiveInt $B) {
    say "Input: A: $A, B: $B";
    say "Divide A by 2 (ignoring remainders) until it is 1. Multiply B by 2 as we go:";
    my @pairs = generate-pairs($A, $B);
    say "Then, wherever A is odd, we add the Bs together:";
    my @odd-bs = @pairs.grep(-> @pair { !(@pair[0] %% 2) }).map(-> @pair { @pair[1] });
    say "{@odd-bs.join(' + ')} = {@odd-bs.sum}";
}
