use v6;

sub MAIN(:$word-file is copy, :$lengthy) {
    my $file = .IO with $word-file;
    my Set $words = Set.new(.lines.sort) with $file;
    return unless $words;

    my &is-word = $words.defined
        ?? -> $w { $w (elem) $words }
        !! -> $w { True };
    my %counts;
    for $words.keys -> $word {
        my $norm = normalize-anagram($word);
        %counts{ $norm }++;
    }

    my $max = %counts.pairs.max({ .value }).value;
    my @patterns = %counts.pairs.grep(*.value == $max)>>.key;
    for @patterns {
        .say;
        "  $_".say for .&anagrams;
    }

    if ($lengthy) {
        say %counts.grep({
            .value > 1
            && .key.chars > @patterns.max(*.chars).chars
        });
    }

    sub anagrams ($word) {
        gather
        for $word.comb.permutations.unique(:with(&[eqv])) {
            with .join {
                .take if .&is-word
            }
        }
    }
    sub normalize-anagram(Str $word) {
        return $word.comb.sort.join;
    }
}

