#!/usr/bin/env raku

# using the algorithm from this video...
# https://www.youtube.com/watch?v=Zb4eRjuPHbM

multi MAIN(*@N where .all ~~ UInt) {
    say jump-game(@N);
}
 
multi MAIN {
    use Test;
    plan 2;

    ok  jump-game([1, 2, 1, 2]),    "Example 1";
    nok jump-game([2, 1, 1, 0, 2]), "Example 2";    
}

sub jump-game(@N) {
    my $last-good-index = @N.end;

    for $last-good-index...0 -> $i {
        if @N[$i] >= $last-good-index - $i {
            $last-good-index = $i;
        }
    }

    +not $last-good-index;
}
