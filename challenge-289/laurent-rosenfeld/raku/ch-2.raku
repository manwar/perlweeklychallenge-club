sub jumble-letters ($in) {
    my @out;
    for $in.words -> $word {
        my @letters = $word.comb;
        my $punctuation = "";
        $punctuation = @letters.pop if $word ~~ /.*\W$/;
        @letters[1..*-2] = @letters[1..*-2].pick: *;
        my $out-word = (join "", @letters) ~ $punctuation;
        push @out, $out-word;
    }
    return join " ", @out;
}

my @tests = "Ask not what your country can do for you, ask what you can do for your country",
            "I have a dream that one day this nation will rise up and live out the true meaning of its creed.",
            "The greatest thing you will ever learn is just to love and be loved in return.";
for @tests -> $test {
    say $test;
    say jumble-letters $test;
    say "";
}
