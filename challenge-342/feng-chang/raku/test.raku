#!/bin/env raku

# The Weekly Challenge 342
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

# Task 1, Balance String
pwc-test './ch-1.raku', 'a0b1c2',  '"0a1b2c"',  'Balance String: a0b1c2  => "0a1b2c"';
pwc-test './ch-1.raku', 'abc12',   '"a1b2c"',   'Balance String: abc12   => "a1b2c"';
pwc-test './ch-1.raku', '0a2b1c3', '"0a1b2c3"', 'Balance String: 0a2b1c3 => "0a1b2c3"';
pwc-test './ch-1.raku', '1a23',    '""',        'Balance String: 1a23    => ""';
pwc-test './ch-1.raku', 'ab123',   '"1a2b3"',   'Balance String: ab123   => "1a2b3"';

# Task 2, Max Score
pwc-test './ch-2.raku', '0011',   4, 'Max Score: 0011   => 4';
pwc-test './ch-2.raku', '0000',   3, 'Max Score: 0000   => 3';
pwc-test './ch-2.raku', '1111',   3, 'Max Score: 1111   => 3';
pwc-test './ch-2.raku', '0101',   3, 'Max Score: 0101   => 3';
pwc-test './ch-2.raku', '011101', 5, 'Max Score: 011101 => 5';
