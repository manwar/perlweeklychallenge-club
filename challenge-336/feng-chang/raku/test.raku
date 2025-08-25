#!/bin/env raku

# The Weekly Challenge 336
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

# Task 1, Equal Group
pwc-test './ch-1.raku', <1 1 2 2 2 2>,             'True',  'Equal Group: (1,1,2,2,2,2)             => true';
pwc-test './ch-1.raku', <1 1 1 2 2 2 3 3>,         'False', 'Equal Group: (1,1,1,2,2,2,3,3)         => false';
pwc-test './ch-1.raku', <5 5 5 5 5 5 7 7 7 7 7 7>, 'True',  'Equal Group: (5,5,5,5,5,5,7,7,7,7,7,7) => true';
pwc-test './ch-1.raku', <1 2 3 4>,                 'False', 'Equal Group: (1,2,3,4)                 => false';
pwc-test './ch-1.raku', <8 8 9 9 10 10 11 11>,     'True',  'Equal Group: (8,8,9,9,10,10,11,11)     => true';

# Task 2, Final Score
pwc-test './ch-2.raku', <5 2 C D +>,               30, 'Final Score: ("5","2","C","D","+")                          =>  30';
pwc-test './ch-2.raku', <5 -2 4 C D 9 + +>,        27, 'Final Score: ("5","-2","4","C","D","9","+","+")             =>  27';
pwc-test './ch-2.raku', <7 D D C + 3>,             45, 'Final Score: ("7","D","D","C","+","3")                      =>  45';
pwc-test './ch-2.raku', <-- -5 -10 + D C +>,      -55, 'Final Score: ("-5","-10","+","D","C","+")                   => -55';
pwc-test './ch-2.raku', <3 6 + D C 8 + D -2 C +>, 128, 'Final Score: ("3","6","+","D","C","8","+","D","-2","C","+") => 128';
