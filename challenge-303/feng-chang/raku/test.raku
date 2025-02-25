#!/bin/env raku

# The Weekly Challenge 300
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

# Task 1, 3-digits Even
pwc-test './ch-1.raku', <2 1 3 0>,   '102,120,130,132,210,230,302,310,312,320', '3-digits Even: 2,1,3,0   => 102,120,130,132,210,230,302,310,312,320';
pwc-test './ch-1.raku', <2 2 8 8 2>, '222,228,282,288,822,828,882',             '3-digits Even: 2,2,8,8,2 => 222,228,282,288,822,828,882';

# Task 2, Delete and Earn
pwc-test './ch-2.raku', <3 4 2>,       6, 'Delete and Earn: 3,4,2       => 6';
pwc-test './ch-2.raku', <2 2 3 3 3 4>, 9, 'Delete and Earn: 2,2,3,3,3,4 => 9';
