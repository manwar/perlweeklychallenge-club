#!/usr/bin/raku

sub MAIN(
    *@words
) {
    my @rows = < qwertyuiop asdfghjkl zxcvbnm >.map({ $_.comb; });
    my @output;

    for @words -> $word {
        my @letters = $word.lc.comb;
        for @rows -> $row {
            if @letters ⊆ @$row {
                @output.push($word);
                last;
            }
        }
    }

    say q{(}, @output.map({ q{"} ~ $_ ~ q{"} }).join(q{,}), q{)};
}
