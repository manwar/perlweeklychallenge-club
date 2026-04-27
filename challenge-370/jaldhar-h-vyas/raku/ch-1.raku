#!/usr/bin/raku

sub MAIN(
    $paragraph,
    *@banned
) {
    my $bannedWords = @banned».lc.Set;
    my %wordCounts;

    for $paragraph.lc.split(/\W+/) -> $word {
        if $word ∉ $bannedWords {
            %wordCounts{$word}++;
        }
    }

    my $bestWord = q{};
    my $bestCount = -∞;

    for %wordCounts.kv -> $word, $count {
        if $count > $bestCount {
            $bestWord = $word;
            $bestCount = $count;
        }
    }

    say $bestWord;
}
