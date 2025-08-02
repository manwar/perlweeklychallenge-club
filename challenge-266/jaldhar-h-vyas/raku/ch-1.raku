#!/usr/bin/raku

sub MAIN(
    Str $line1,
    Str $line2
) {
    my @words1 = $line1.words.Bag.grep({ $_.value == 1; }).map({ $_.key });
    my @words2 = $line2.words.Bag.grep({ $_.value == 1; }).map({ $_.key });

    say q{(}, ((@words1 ⊖ @words2).map({ "'{$_.key}'" }).join(q{, }) || "''"), q{)};
}