sub most-frequent-word(Str $p, Str $w) {
    # Clean and split the paragraph into words
    my @words = $p.subst(/<-[A..Za..z0..9\s]>/, '', :g).split(/\s+/).map(*.lc);

    # Count the frequency of each word, excluding the banned word
    my %word-count = @words.grep(* ne $w).Bag;

    # Find the most frequent word
    return %word-count.sort(*.value).reverse.head.key;
}

# Test cases
say most-frequent-word("Joe hit a ball, the hit ball flew far after it was hit.", "hit");
say most-frequent-word("Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.", "the");
