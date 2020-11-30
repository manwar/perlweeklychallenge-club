#!/usr/bin/env perl6

sub MAIN($N where $N ~~ Int && $N > 0) {
    my @pairs = (1..$N).combinations(2);
    say [+] @pairs.map(-> @pair { @pair[0] gcd @pair[1] });
}
