#!/bin/env raku

# The Weekly Challenge 225
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Max Words
pwc-test './ch-1.raku',
    "Perl and Raku belong to the same family.",
    "I love Perl.",
    "The Perl and Raku Conference.",
    8,
    'Max Words: example 1, output: 8';
pwc-test './ch-1.raku',
    "The Weekly Challenge.",
    "Python is the most popular guest language.",
    "Team PWC has over 300 members.",
    7,
    'Max Words: example 2, output: 7';

# Task 2, Left Right Sum Diff
pwc-test './ch-2.raku', |<10 4 8 3>,  '15, 1, 11, 22',    'Left Right Sum Diff: (10, 4, 8, 3) => (15, 1, 11, 22)';
pwc-test './ch-2.raku', 0,            '0',                'Left Right Sum Diff: (0) => (0)';
pwc-test './ch-2.raku', |<1 2 3 4 5>, '14, 11, 6, 1, 10', 'Left Right Sum Diff: (1, 2, 3, 4, 5) => (14, 11, 6, 1, 10)';

done-testing;
