sub goat-latin ($in) {
    my $consonants = (('a'..'z').Set ∪ ('A'..'Z').Set)
        (-) <a e i o u A E I O U>.Set;
    my @out;
    my $wc = 0;
    for $in.words -> $word {
        my $result = $word;
        $wc++;
        if (substr $result, 0, 1)  ∈ $consonants {
            $result = (substr $word, 1) ~ (substr $result, 0, 1);
        }
        $result ~= "ma";
        $result ~= 'a' x  $wc;
        push @out, $result;
    }
    return join " ", @out;
}
my @tests = "I love Perl", "Perl and Raku are friends",
    "The Weekly Challenge";
for @tests -> $test {
    say "English: $test";
    say "Goat Latin: ", goat-latin $test;
    say "-----";
}
