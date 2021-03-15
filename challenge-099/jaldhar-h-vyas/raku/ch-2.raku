#!/usr/bin/raku

sub MAIN (
    Str $S, #= a string.
    Str $T  #= a subsequence to be matched in <S>
) {
    my @patterns = ( $T );
    for 0 .. $T.chars - 2 -> $i {
        for 1 .. $S.chars - $T.chars -> $j {
            my @t = $T.comb;
            @t[$i] ~= " . ** {$j} ";
            @patterns.push( / <{ @t.join(q{}) }> / );
        }
    }

    my $count = 0;
    for @patterns -> $pattern {
        if $S ~~ / ( $pattern ) / {
            $count++;
        }
    }

    say $count;
}