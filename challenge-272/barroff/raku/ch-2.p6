#!/usr/bin/env raku

use v6.d;

sub string-score(Str $str --> Int) {
    my @ascii-values = $str.ords;
    sum(
        map(
            { abs(
                @ascii-values[$_] - @ascii-values[$_ + 1]
            ) },
            0..$str.chars - 2
        )
    );
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is string-score("hello"), 13, 'works for "hello"';
    is string-score("perl"), 30, 'works for "perl"';
    is string-score("raku"), 37, 'works for "raku"';
}

#| Take user provided string like "hello"
multi sub MAIN(Str $str) {
    say string-score($str);
}
