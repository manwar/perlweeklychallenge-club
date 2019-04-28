use v6;

sub MAIN(Str $word, :$word-file) {
    my $file = .IO with $word-file;
    my Set $words = Set.new(.lines.sort) with $file;
    my &is-word = $words.defined
        ?? -> $w { $w (elem) $words }
        !! -> $w { True };
    for $word.comb.permutations.unique(:with(&[eqv])) {
        with .join {
            .say if .&is-word
        }
    }
}


