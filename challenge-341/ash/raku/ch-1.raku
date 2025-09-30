# Task 1 of the Weekly Challenge 341
# https://theweeklychallenge.org/blog/perl-weekly-challenge-341/#TASK1

say count-words('Hello World', ['d']); # 1
say count-words('apple banana cherry', ['a', 'e']); # 0
say count-words('Coding is fun', []); # 3
say count-words('The Weekly Challenge', ['a','b']); # 2
say count-words('Perl and Python', ['p']); # 1

sub count-words($string, @broken-keys) {
    my @words = $string.lc.words;
    my $possible-words = @words.elems;
    for @words -> $word {
        $possible-words-- if $word.comb (&) @broken-keys;
    }

    return $possible-words;
}
