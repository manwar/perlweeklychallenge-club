sub max-words (@sentences) {
    my $max = 0;
    for @sentences -> $sentence {
        my $cw = $sentence.words.elems;
        $max = $cw if $cw > $max;
    }
    return $max;
}

my @tests =
    ("The quick brown fox jumps over the lazy dog",
        "Lorem ipsum dolor sit amet"),
    ("Perl and Raku belong to the same family.",
        "I love Perl.",
        "The Perl and Raku Conference."),
    ("The Weekly Challenge.",
        "Python is the most popular guest language.",
        "Team PWC has over 300 members.");
for @tests -> @test {
    say max-words @test;
}
