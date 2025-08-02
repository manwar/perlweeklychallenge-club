#!/bin/env raku

# The Weekly Challenge 252
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

# Task 1, Special Numbers
pwc-test './ch-1.raku', |<1 2 3 4>,       21, 'Special Numbers: (1, 2, 3, 4)         => 21';
pwc-test './ch-1.raku', |<2 7 1 19 18 3>, 63, 'Special Numbers: (2, 7, 1, 19, 18, 3) => 63';

sub pwc252-p2-test(Str:D $script, $n) {
    my $p = run $script, $n, :out;
    my @ints = +«$p.out.slurp(:close).chomp.words;

    ok (@ints.all ~~ Int and @ints.sum == 0 and +@ints.unique == +@ints), "$n => ({@ints.join(', ')})";
}

# Task 2, Unique Sum Zero
pwc252-p2-test './ch-2.raku', 5;
pwc252-p2-test './ch-2.raku', 3;
pwc252-p2-test './ch-2.raku', 1;

done-testing;
