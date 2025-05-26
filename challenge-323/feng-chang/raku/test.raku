#!/bin/env raku

# The Weekly Challenge 323
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

# Task 1, Increment Decrement
pwc-test './ch-1.raku', '--', '--x x++ x++',     1, 'Increment Decrement: "--x x++ x++"     => 1';
pwc-test './ch-1.raku', '--', 'x++ ++x x++',     3, 'Increment Decrement: "x++ ++x x++"     => 3';
pwc-test './ch-1.raku', '--', 'x++ ++x --x x--', 0, 'Increment Decrement: "x++ ++x --x x--" => 0';

# Task 2, Tax Amount
pwc-test './ch-2.raku', '$income=10, @tax=[3,50],[7,10],[12,25]', 2.65, 'Tax Amount: "$income=10, @tax=[3,50],[7,10],[12,25]" => 2.65';
pwc-test './ch-2.raku', '$income=2,  @tax=[1,0],[4,25],[5,50]',   0.25, 'Tax Amount: "$income=2,  @tax=[1,0],[4,25],[5,50]"   => 0.25';
pwc-test './ch-2.raku', '$income=0,  @tax=[2, 50],',              0,    'Tax Amount: "$income=0,  @tax=[2, 50]"               => 0';
