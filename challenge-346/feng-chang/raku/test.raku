#!/bin/env raku

# The Weekly Challenge 346
use Test;

sub pwc-test(Str:D $script, Bool :$deeply? = False, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    if $deeply {
        is-deeply $p.out.slurp(:close).chomp.words.Bag, $expect, $assertion;
    } else {
        is $p.out.slurp(:close).chomp, $expect, $assertion;
    }
}

# Task 1, Longest Parenthesis
pwc-test './ch-1.raku', '(()())',        6, 'Longest Parenthesis: (()())        => 6';
pwc-test './ch-1.raku', ')()())',        4, 'Longest Parenthesis: )()())        => 4';
pwc-test './ch-1.raku', '((()))()(((()', 8, 'Longest Parenthesis: ((()))()(((() => 8';
pwc-test './ch-1.raku', '))))((()(',     2, 'Longest Parenthesis: ))))((()(     => 2';
pwc-test './ch-1.raku', '()(()',         2, 'Longest Parenthesis: ()(()         => 2';
pwc-test './ch-1.raku', '()(()()',       4, 'Longest Parenthesis: ()(()()       => 4';

# Task 2, Magic Expression
pwc-test './ch-2.raku', 123,   6, '1+2+3, 1*2*3',     'Magic Expression: 123,6   => "1+2+3, 1*2*3"';
pwc-test './ch-2.raku', 105,   5, '1*0+5, 10-5',      'Magic Expression: 105,5   => "1*0+5, 10-5"';
pwc-test './ch-2.raku', 232,   8, '2+3*2, 2*3+2',     'Magic Expression: 232,8   => "2+3*2, 2*3+2"';
pwc-test './ch-2.raku', 1234, 10, '1+2+3+4, 1*2*3+4', 'Magic Expression: 1234,10 => "1+2+3+4, 1*2*3+4"';
pwc-test './ch-2.raku', 1001,  2,
            '1+0+0+1, 1+0-0+1, 1+0*0+1, 1-0+0+1, 1-0-0+1, 1-0*0+1',
            'Magic Expression: 1001,2  => "1+0+0+1, 1+0-0+1, 1+0*0+1, 1-0+0+1, 1-0-0+1, 1-0*0+1"';
