#!/usr/bin/env raku

use v6.d;

sub most-frequent-word(Str:D $p, Str:D $w --> Str:D) {
    my $frequencies = Bag(
        grep(
            { not($_ ~~ /$w/) },
            split(
                /\W+/,
                $p
            )
        )
    );
    sort(
        { $frequencies{$^a} ≤ $frequencies{$^b}},
        keys($frequencies)
    )[0];
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is most-frequent-word(
        "Joe hit a ball, the hit ball flew far after it was hit.",
        "hit"
    ), "ball", 'works for "hit"';
    is most-frequent-word("Perl and Raku belong to the same family." ~
        " Perl is the most popular language in the weekly challenge.",
        "the"
    ), "Perl", 'works for "Perl"';
}

#| Take user provided word like aba
multi sub MAIN(Str:D $p, Str:D $w) {
    say most-frequent-word($p, $w);
}
