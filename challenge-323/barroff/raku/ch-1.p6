#!/usr/bin/env raku

use v6.d;

my regex inc-dec { [ "++" | "--" ] }
my regex operation { [ <inc-dec> "x" | "x" <inc-dec> ] };

sub increment-decrement(@operations --> Int) {
    my $count-positive = grep({ /\+\+/ }, @operations).elems;
    2 × $count-positive - @operations.elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is increment-decrement(["--x", "x++", "x++"]), 1, 'works for "--x", "x++", "x++"';
    is increment-decrement(["x++", "++x", "x++"]), 3, 'works for "x++", "++x", "x++"';
    is increment-decrement(["x++", "++x", "--x", "x--"]), 0,
        'works for "x++", "++x", "--x", "x--"';
}

#| Take user provided strings like "x++" "++x" "--x" "x--"
# multi sub MAIN(*@operations where @operations.all ~~ / <operation> /) {
multi sub MAIN(
    Bool :$x = False,
    *@operations where @operations.all ~~ / <operation> /
) {
    say increment-decrement(@operations) - $x.Int ;
}
