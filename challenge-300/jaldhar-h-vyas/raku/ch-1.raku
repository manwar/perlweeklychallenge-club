#!/usr/bin/raku

sub backtrack($int, $pos) {
    state @used = False xx ($int + 1);
    my $count = 0;

    if $pos > $int {
        return 1;
    }

    for 1 .. $int -> $i {
        if !@used[$i] && ($i %% $pos || $pos %% $i) {
            @used[$i] = True;
            $count += backtrack($int, $pos + 1);
            @used[$i] = False;
        }
    }

    return $count;
}

sub MAIN(
    Int $int
) {
    say backtrack($int, 1);
}
