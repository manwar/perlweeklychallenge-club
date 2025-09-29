# Task 2 of the Weekly Challenge 341
# https://theweeklychallenge.org/blog/perl-weekly-challenge-341/#TASK2

say reverse-prefix('programming', 'g'); # gorpramming
say reverse-prefix('hello', 'h'); # hello
say reverse-prefix('abcdefghij', 'h'); # hgfedcbaij
say reverse-prefix('reverse', 's'); # srevere
say reverse-prefix('perl', 'r'); # repl

sub reverse-prefix($word, $char) {
    $word ~~ /^ (.*? $char) (.*) $/;

    return $/[0].flip ~ $/[1];
}
