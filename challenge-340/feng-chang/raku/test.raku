#!/bin/env raku

# The Weekly Challenge 340
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

# Task 1, Duplicate Removals
pwc-test './ch-1.raku', 'abbaca',   'ca', 'Duplicate Removals: abbaca   => ca';
pwc-test './ch-1.raku', 'azxxzy',   'ay', 'Duplicate Removals: azxxzy   => ay';
pwc-test './ch-1.raku', 'aaaaaaaa', '',   'Duplicate Removals: aaaaaaaa => ""';
pwc-test './ch-1.raku', 'aabccba',  'a',  'Duplicate Removals: aabccba  => a';
pwc-test './ch-1.raku', 'abcddcba', '',   'Duplicate Removals: abcddcba => ""';

# Task 2, Ascending Numbers
pwc-test './ch-2.raku', 'The cat has 3 kittens 7 toys 10 beds',      'True',  'Ascending Numbers: "The cat has 3 kittens 7 toys 10 beds"      => true';
pwc-test './ch-2.raku', 'Alice bought 5 apples 2 oranges 9 bananas', 'False', 'Ascending Numbers: "Alice bought 5 apples 2 oranges 9 bananas" => false';
pwc-test './ch-2.raku', 'I ran 1 mile 2 days 3 weeks 4 months',      'True',  'Ascending Numbers: "I ran 1 mile 2 days 3 weeks 4 months"      => true';
pwc-test './ch-2.raku', 'Bob has 10 cars 10 bikes',                  'False', 'Ascending Numbers: "Bob has 10 cars 10 bikes"                  => false';
pwc-test './ch-2.raku', 'Zero is 0 one is 1 two is 2',               'True',  'Ascending Numbers: "Zero is 0 one is 1 two is 2"               => Ture';
