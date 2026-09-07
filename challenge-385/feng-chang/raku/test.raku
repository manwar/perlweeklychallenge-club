#!/bin/env raku

# The Weekly Challenge 385
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

# Task 1, Uncommon Words
pwc-test './ch-1.raku', 'apple banana apple', 'banana orange',     'orange',            'Uncommon Words: "apple banana apple", "banana orange" => "orange"';
pwc-test './ch-1.raku', 'cat dog', 'bird fish',                    'bird cat dog fish', 'Uncommon Words: "cat dog", "bird fish"                => "bird cat dog fish"';
pwc-test './ch-1.raku', 'the quick brown fox', 'the quick',        'brown fox',         'Uncommon Words: "the quick brown fox", "the quick"    => "brown fox"';
pwc-test './ch-1.raku', 'hello', 'hello',                          '',                  'Uncommon Words: "hello", "hello"                      => ""';
pwc-test './ch-1.raku', 'blue blue red', 'red green green yellow', 'yellow',            'Uncommon Words: "the quick brown fox", "the quick"    => "brown fox"';

# Task 2, Outermost Parentheses
pwc-test './ch-2.raku', '()()()',         '',           'Outermost Parentheses: ()()()         => ""';
pwc-test './ch-2.raku', '(((())))',       '((()))',     'Outermost Parentheses: (((())))       => ((()))';
pwc-test './ch-2.raku', '(()())(())',     '()()()',     'Outermost Parentheses: (()())(())     => ()()()';
pwc-test './ch-2.raku', '()((()))()',     '(())',       'Outermost Parentheses: ()((()))()     => (())';
pwc-test './ch-2.raku', '(()(()))(()())', '()(())()()', 'Outermost Parentheses: (()(()))(()()) => ()(())()()';
