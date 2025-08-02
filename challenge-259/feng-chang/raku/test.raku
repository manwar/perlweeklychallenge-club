#!/bin/env raku

# The Weekly Challenge 259
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

# Task 1, Banking Day Offset
pwc-test './ch-1.raku', '2018-06-28', 3, <2018-07-03>, '2018-07-04',
    'Banking Day Offset: $start_date = "2018-06-28", $offset = 3, $bank_holidays = ["2018-07-03"] => "2018-07-04"';
pwc-test './ch-1.raku', '2018-06-28', 3,               '2018-07-03',
    'Banking Day Offset: $start_date = "2018-06-28", $offset = 3                                  => "2018-07-03"';
