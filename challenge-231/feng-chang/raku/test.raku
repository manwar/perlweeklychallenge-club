#!/bin/env raku

# The Weekly Challenge 231
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Min Max
pwc-test './ch-1.raku', |<3 2 1 4>, '3 2', 'Min Max: (3, 2, 1, 4) => 3 2';
pwc-test './ch-1.raku', |<3 1>,     -1,    'Min Max: (3, 1)       => -1';
pwc-test './ch-1.raku', |<2 1 3>,   2,     'Min Max: (2, 1, 3)    => 2';

# Task 2, Senior Citizens
pwc-test './ch-2.raku',
    |<7868190130M7522 5303914400F9211 9273338290F4010>,
    2,
    'Senior Citizens: ("7868190130M7522","5303914400F9211","9273338290F4010") => 2';
pwc-test './ch-2.raku',
    |<1313579440F2036 2921522980M5644>,
    0,
    'Senior Citizens: ("1313579440F2036","2921522980M5644")                   => 0';

done-testing;
