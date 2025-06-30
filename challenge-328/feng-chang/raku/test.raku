#!/bin/env raku

# The Weekly Challenge 328
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

# Task 1, Replace All ?
pwc-test './ch-1.raku', 'a?z',    'abz',    'Replace All ?: a?z    => abz';
pwc-test './ch-1.raku', 'pe?k',   'peak',   'Replace All ?: pe?k   => peak';
pwc-test './ch-1.raku', 'gra?te', 'grabte', 'Replace All ?: gra?te => grabte';

# Task 2, Good String
pwc-test './ch-2.raku', 'WeEeekly', 'Weekly', 'Good String: WeEeekly => Weekly';
pwc-test './ch-2.raku', 'abBAdD',   '',       'Good String: abBAdD   => ""';
pwc-test './ch-2.raku', 'abc',      'abc',    'Good String: abc      => abc';
