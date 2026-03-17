#!/bin/env raku

# The Weekly Challenge 362
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

# Task 1, Echo Chamber
pwc-test './ch-1.raku', 'abca',  'abbcccaaaa',      'Echo Chamber: abca  => abbcccaaaa';
pwc-test './ch-1.raku', 'xyz',   'xyyzzz',          'Echo Chamber: xyz   => xyyzzz';
pwc-test './ch-1.raku', 'code',  'coodddeeee',      'Echo Chamber: code  => coodddeeee';
pwc-test './ch-1.raku', 'hello', 'heelllllllooooo', 'Echo Chamber: hello => heelllllllooooo';
pwc-test './ch-1.raku', 'a',     'a',               'Echo Chamber: a     => a';

# Task 2, Spellbound Sorting
pwc-test './ch-2.raku', <6 7 8 9 10>,      '8 9 7 6 10',    'Spellbound Sorting: 6,7,8,9,10    => 8,9,7,6,10';
pwc-test './ch-2.raku', <-- -3 0 1000 99>, '-3 99 1000 0',  'Spellbound Sorting: -3,0,1000,99  => -3,99,1000,0';
pwc-test './ch-2.raku', <1 2 3 4 5>,       '5 4 1 3 2',     'Spellbound Sorting: 1,2,3,4,5     => 5,4,1,3,2';
pwc-test './ch-2.raku', <0 -1 -2 -3 -4>,   '-4 -1 -3 -2 0', 'Spellbound Sorting: 0,-1,-2,-3,-4 => -4,-1,-3,-2,0';
pwc-test './ch-2.raku', <100 101 102>,     '100 101 102',   'Spellbound Sorting: 100,101,102   => 100,101,102';
