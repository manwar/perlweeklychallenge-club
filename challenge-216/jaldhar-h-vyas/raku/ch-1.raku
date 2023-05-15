#!/usr/bin/raku

sub MAIN(
    $reg, *@words
) {
    my @registration = $reg.comb.grep({$_ ~~ /<alpha>/}).unique.map({ $_.lc });
    my @results;

    for @words -> $word {
        my @w = $word.comb.grep({$_ ~~ /<alpha>/}).unique.map({ $_.lc });
        if @registration ⊆ @w {
            @results.push($word);
        }
    }

    say q{(}, @results.map({"'$_'"}).join(q{, }), q{)};
}