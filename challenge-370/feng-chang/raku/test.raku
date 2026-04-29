#!/bin/env raku

# The Weekly Challenge 370
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

# Task 1, Popular Words
pwc-test './ch-1.raku',
    'Bob hit a ball, the hit BALL flew far after it was hit.',
    <hit>,
    'ball',
    'Popular Words: "Bob hit a ball, the hit BALL flew far after it was hit.", @banned=<hit> => ball';
pwc-test './ch-1.raku',
    'Apple? apple! Apple, pear, orange, pear, apple, orange.',
    <apple pear>,
    'orange',
    'Popular Words: "Apple? apple! Apple, pear, orange, pear, apple, orange.", @banned=<apple pear> => orange';
pwc-test './ch-1.raku',
    'A. a, a! A. B. b. b.',
    <b>,
    'a',
    'Popular Words: "A. a, a! A. B. b. b.", @banned=<b> => a';
pwc-test './ch-1.raku',
    'Ball.ball,ball:apple!apple.banana',
    <ball>,
    'apple',
    'Popular Words: "Ball.ball,ball:apple!apple.banana", @banned=<ball> => apple';
pwc-test './ch-1.raku',
    'The dog chased the cat, but the dog was faster than the cat.',
    <the dog>,
    'cat',
    'Popular Words: "The dog chased the cat, but the dog was faster than the cat.", @banned=<the dog> => cat';

# Task 2, Scramble String
pwc-test './ch-2.raku', <abc   acb>,   'True',  'Scramble String: abc,   acb   => true';
pwc-test './ch-2.raku', <abcd  cdba>,  'True',  'Scramble String: abcd,  cdba  => true';
pwc-test './ch-2.raku', <hello hiiii>, 'False', 'Scramble String: hello, hiiii => false';
pwc-test './ch-2.raku', <ateer eater>, 'True',  'Scramble String: ateer, eater => true';
pwc-test './ch-2.raku', <abcd  bdac>,  'False', 'Scramble String: abcd,  bdac  => false';
