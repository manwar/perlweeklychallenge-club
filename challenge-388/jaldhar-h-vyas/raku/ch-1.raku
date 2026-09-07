#!/usr/bin/raku

sub dyckWords($n, $up, $down, $prefix) {
    if $prefix.chars == 2 * $n {
        return ($prefix);
    }

    my @words;

    if $up < $n {
        @words.push(| dyckWords($n, $up + 1, $down, $prefix ~ 'U'));
    }

    if $down < $up {
        @words.push(| dyckWords($n, $up, $down + 1, $prefix ~ 'D'));
    }

    return @words;
}

sub MAIN(
    $n
) {
    my @words = dyckWords($n, 0, 0, q{});

    say q{(}, @words.sort.map({ "\"$_\"" }).join(', '), q{)};
}
