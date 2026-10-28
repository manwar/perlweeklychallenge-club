#!/usr/bin/raku

sub MAIN(
    *@S
) {
    my %words;
    for @S -> $word {
        %words{$word.comb.sort.join}.push($word);
    }

    say
         q{[ },
        %words
            .values
            .grep({ @S.elems == 1 ||  $_.elems > 1 })
            .map({ q{(} ~ $_.map({ "\"$_\"" }).join(q{, }) ~ q{)} })
            .join(",\n"),
        q{ ]};
}
