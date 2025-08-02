#!/bin/env raku

# The Weekly Challenge 279
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

# Task 1, Sort Letters
pwc-test './ch-1.raku', 'R,E,P,L',     '3,2,1,4',     'PERL',   'Sort Letters: <R E P L>,     3,2,1,4     => PERL';
pwc-test './ch-1.raku', 'A,U,R,K',     '2,4,1,3',     'RAKU',   'Sort Letters: <A U R K>,     2,4,1,3     => RAKU';
pwc-test './ch-1.raku', 'O,H,Y,N,P,T', '5,4,2,6,1,3', 'PYTHON', 'Sort Letters: <O H Y N P T>, 5,4,2,6,1,3 => PYTHON';

# Task 2, Split String
pwc-test './ch-2.raku', 'perl',         'False', 'Split String: "perl"         => False';
pwc-test './ch-2.raku', 'book',         'True',  'Split String: "book"         => True';
pwc-test './ch-2.raku', 'good morning', 'True',  'Split String: "good morning" => True';
