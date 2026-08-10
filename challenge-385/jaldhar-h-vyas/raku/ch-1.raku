#!/usr/bin/raku

sub MAIN(
    $sentence1,
    $sentence2
) {
    my $allWords = BagHash.new;
    $allWords.add($sentence1.words);
    $allWords.add($sentence2.words);

    say
        q{(},
        $allWords
            .keys
            .grep({ $allWords{$_} == 1 })
            .map({ "\"$_.\"" })
            .join(q{, }),
        q{)};
}
