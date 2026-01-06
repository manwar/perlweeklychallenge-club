#!/bin/env raku

# The Weekly Challenge 355
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

# Task 1, Thousand Separator
pwc-test './ch-1.raku', 123,     '123',       'Thousand Separator: 123     => 123';
pwc-test './ch-1.raku', 1234,    '1,234',     'Thousand Separator: 1234    => 1,234';
pwc-test './ch-1.raku', 1000000, '1,000,000', 'Thousand Separator: 1000000 => 1,000,000';
pwc-test './ch-1.raku', 1,       '1',         'Thousand Separator: 1       => 1';
pwc-test './ch-1.raku', 12345,   '12,345',    'Thousand Separator: 12345   => 12,345';

# Task 2, Mountain Array
pwc-test './ch-2.raku', <1 2 3 4 5>,     'false', 'Mountain Array: 1,2,3,4,5     => false';
pwc-test './ch-2.raku', <0 2 4 6 4 2 0>, 'true',  'Mountain Array: 0,2,4,6,4,2,0 => true';
pwc-test './ch-2.raku', <5 4 3 2 1>,     'false', 'Mountain Array: 5,4,3,2,1     => false';
pwc-test './ch-2.raku', <1 3 5 5 4 2>,   'false', 'Mountain Array: 1,3,5,5,4,2   => false';
pwc-test './ch-2.raku', <1 3 2>,         'true',  'Mountain Array: 1,3,2         => true';
