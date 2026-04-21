#!/bin/env raku

# The Weekly Challenge 368
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

# Task 1, Make It Bigger
pwc-test './ch-1.raku', 15456,  5, 1546,  'Make It Bigger: 15456,  5 => 1546';
pwc-test './ch-1.raku', 7332,   3, 732,   'Make It Bigger: 7332,   3 => 732';
pwc-test './ch-1.raku', 2231,   2, 231,   'Make It Bigger: 2231,   2 => 231';
pwc-test './ch-1.raku', 543251, 5, 54321, 'Make It Bigger: 543251, 5 => 54321';
pwc-test './ch-1.raku', 1921,   1, 921,   'Make It Bigger: 1921,   1 => 921';

# Task 2, Big and Little Omega
pwc-test './ch-2.raku', <100061 0>, 3, 'Big and Little Omega: $number=100061, $mode=0 => 3';
pwc-test './ch-2.raku', <971088 0>, 3, 'Big and Little Omega: $number=971088, $mode=0 => 3';
pwc-test './ch-2.raku', <63640  1>, 6, 'Big and Little Omega: $number=63640,  $mode=1 => 6';
pwc-test './ch-2.raku', <988841 1>, 2, 'Big and Little Omega: $number=988841, $mode=1 => 2';
pwc-test './ch-2.raku', <211529 0>, 2, 'Big and Little Omega: $number=211529, $mode=0 => 2';
