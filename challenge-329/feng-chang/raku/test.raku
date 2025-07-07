#!/bin/env raku

# The Weekly Challenge 329
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

# Task 1, Count Integers
pwc-test './ch-1.raku', 'the1weekly2challenge2', '1 2',      'Count Integers: the1weekly2challenge2 => 1,2';
pwc-test './ch-1.raku', 'go21od1lu5c7k',         '21 1 5 7', 'Count Integers: go21od1lu5c7k         => 21,1,5,7';
pwc-test './ch-1.raku', '4p3e2r1l',              '4 3 2 1',  'Count Integers: 4p3e2r1l              => 4,3,2,1';

# Task 2, Nice String
pwc-test './ch-2.raku', 'YaaAho',     'aaA',  'Nice String: YaaAho     => aaA';
pwc-test './ch-2.raku', 'cC',         'cC',   'Nice String: cC         => cC';
pwc-test './ch-2.raku', 'A',          '',     'Nice String: A          => ""';
pwc-test './ch-2.raku', 'YaaAhCccCo', 'CccC', 'Nice String: YaaAhCccCo => CccC';
