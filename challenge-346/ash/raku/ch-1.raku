# Task 1 of The Weekly Challenge 346
# https://theweeklychallenge.org/blog/perl-weekly-challenge-346/#TASK1

say paren-len '(()())'; # 6
say paren-len ')()())'; # 4
say paren-len '((()))()(((()'; # 8
say paren-len '))))((()('; # 2
say paren-len '()(()'; # 2

# An extra example to find the longest string out of the two options
say paren-len '()((())'; # 4

grammar parens {
    rule sequence {
        <balanced>+
    }

    rule balanced {
        '(' <balanced>* ')'
    }
}

sub paren-len($s) {
    $s.match(/<parens::sequence>/, :g)>>.chars.max;
}
