#!/usr/bin/raku

sub MAIN(
    $initial,
    *@encoded
) {
    my @decoded = ($initial);

    for @encoded -> $n {
        @decoded.push($n +^ @decoded[*-1]);
    }

    say q{(}, @decoded.join(q{, }), q{)};
}
