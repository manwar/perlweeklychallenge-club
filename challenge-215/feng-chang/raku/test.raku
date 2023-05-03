#!/bin/env raku

use Test;

# The Weekly Challenge 215

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Odd One Out
pwc-test './ch-1.raku', |<abc xyz tsu>, 1, "Odd One out: 'abc', 'xyz', 'tsu' => 1";
pwc-test './ch-1.raku', |<rat cab dad>, 3, "Odd One out: 'rat', 'cab', 'dad' => 3";
pwc-test './ch-1.raku', |<x y z>,       0, "Odd One out: 'x', 'y', 'z'       => 0";

# Task 2, Number Placement
pwc-test './ch-2.raku', |<1 0 0 0 1>, 1, 1, 'Number Placement: @numbers = (1,0,0,0,1), $count = 1 => 1';
pwc-test './ch-2.raku', |<1 0 0 0 1>, 2, 0, 'Number Placement: @numbers = (1,0,0,0,1), $count = 2 => 0';
pwc-test './ch-2.raku', |<1 0 0 0 0 0 0 0 1>, 3, 1, 'Number Placement: @numbers = (1,0,0,0,0,0,0,0,1), $count = 3 => 1';

pwc-test './ch-2.raku', |<0 0 0 0 0>, 3, 1, 'Number Placement: @numbers = (0,0,0,0,0), $count = 3 => 1';
pwc-test './ch-2.raku', |<0 0 0 0 0>, 4, 0, 'Number Placement: @numbers = (0,0,0,0,0), $count = 4 => 0';
pwc-test './ch-2.raku', |<1 0 0 0 0 0 0 0 1>, 5, 1, 'Number Placement: @numbers = (1,0,0,0,0,0,0,0,1), $count = 5 => 1';
pwc-test './ch-2.raku', |<1 0 0 0 0 0 0 0 1>, 6, 0, 'Number Placement: @numbers = (1,0,0,0,0,0,0,0,1), $count = 6 => 0';
pwc-test './ch-2.raku', |<1 0 0 0 1 0 0 0 1>, 2, 1, 'Number Placement: @numbers = (1,0,0,0,1,0,0,0,1), $count = 2 => 1';
pwc-test './ch-2.raku', |<1 0 0 0 1 0 0 0 1>, 3, 0, 'Number Placement: @numbers = (1,0,0,0,1,0,0,0,1), $count = 3 => 0';

done-testing;
