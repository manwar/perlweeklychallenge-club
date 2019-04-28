use v6;

sub MAIN(:$word-file!, :$lengthy) {
    my $file = .IO with $word-file;
    my Set $words = Set.new(.lines.sort) with $file;

    sub is-word ($w) {
        $w (elem) $words;
    }
    my %counts;
    for $words.keys -> $word {
        my $norm = normalize-anagram($word);
        %counts{ $norm }++;
    }

    my $max = %counts.pairs.max({ .value }).value;
    my @patterns = %counts.pairs.grep(*.value == $max)>>.key;
    for @patterns {
        .say;
        for .&anagrams(&is-word) {
            "  $_".say;
        }
    }

    if ($lengthy) {
        say %counts.grep({
            .value > 4
            && .key.chars > @patterns.max(*.chars).chars
        });
    }

    sub normalize-anagram(Str $word) {
        return $word.comb.sort.join;
    }
}

sub anagrams ($word, &is-word = -> $w { True }) {
    gather
    for $word.comb.permutations.unique(:with(&[eqv])) {
        with .join {
            .take if .&is-word
        }
    }
}
