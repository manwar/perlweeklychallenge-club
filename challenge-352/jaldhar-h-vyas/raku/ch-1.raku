#!/usr/bin/raku

sub MAIN(
    *@words
) {
    my @substrings;

    for 0 .. @words.end -> $i {
        for 0 .. @words.end -> $j {
            if $i != $j && @words[$j].index(@words[$i]) !~~ Nil {
                @substrings.push(@words[$i]);
                last;
            }
        }
    }

    say q{(}, @substrings.unique.map({ "\"$_\"" }).join(q{, }), q{)};
}