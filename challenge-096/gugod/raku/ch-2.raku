sub MAIN {
    my @examples = (
        [ 'kitten', 'sitting' ],
        [ 'sunday', 'monday' ],
    );

    for @examples -> ($S1, $S2) {
        say "Input: \$S1 = $S1, \$S2 = $S2";
        say "Output: " ~ edit-distance($S1, $S2);
    }
}

sub edit-distance (Str $S1, Str $S2 --> Int) {
    my sub lev ($a, $b) {
        return $a.chars if $b.chars == 0;
        return $b.chars if $a.chars == 0;
        return lev( $a.substr(1), $b.substr(1) ) if $a.substr(0,1) eq $b.substr(0,1);
        return 1 + (
            lev($a, $b.substr(1)),
            lev($a.substr(1), $b),
            lev($a.substr(1), $b.substr(1)),
        ).min;
    };

    return lev($S1, $S2);
}
