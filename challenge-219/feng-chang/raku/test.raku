#!/bin/env raku

# The Weekly Challenge 219
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Sorted Squares
pwc-test './ch-1.raku', '--', |<-2 -1 0 3 4>, '0, 1, 4, 9, 16',   'Sorted Squares:  -2, -1, 0, 3, 4 => 0, 1, 4, 9, 16';
pwc-test './ch-1.raku', '--', |<5 -4 -1 3 6>, '1, 9, 16, 25, 36', 'Sorted Squares:  5, -4, -1, 3, 6 => 1, 9, 16, 25, 36';

# Task 2, Travel Expenditure
pwc-test './ch-2.raku', '@costs = (2, 7, 25); @days = (1, 5, 6, 7, 9, 15)', 11,
    'Travel Expenditure: @costs = (2, 7, 25); @days = (1, 5, 6, 7, 9, 15) => 11';
pwc-test './ch-2.raku', '@costs = (2, 7, 25); @days = (1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31)', 20,
    'Travel Expenditure: @costs = (2, 7, 25); @days = (1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31) => 20';

done-testing;
