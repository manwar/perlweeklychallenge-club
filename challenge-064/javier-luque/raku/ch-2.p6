# Test: perl6 ch-2.p6

sub MAIN() {
    my $S = "perlweeklychallenge";
    my @W = ("weekly", "challenge", "perl");
    say $S;
    say check-word($S, @W);

    my $S2 = "perlandraku";
    my @W2 = ("python", "ruby", "haskell");
    say "\n" ~ $S2;
    say check-word($S2, @W2);
}

sub check-word(Str $string, @words) {
    my @split_words =
    	$string.split(/<@words>/, :v, :skip-empty);

    return (@split_words.elems == @words.elems) ??
    	@split_words.join(" ") !! 0;
}
