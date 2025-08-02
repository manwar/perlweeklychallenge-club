#!/bin/env raku

# The Weekly Challenge 258
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

# Task 1, Count Even Digits Number
pwc-test './ch-1.raku', <10 1 111 24 1000>, 3, 'Count Even Digits Number: 10, 1, 111, 24, 1000 => 3';
pwc-test './ch-1.raku', <111 1 11111>,      0, 'Count Even Digits Number: 111, 1, 11111        => 0';
pwc-test './ch-1.raku', <2 8 1024 256>,     1, 'Count Even Digits Number: 2, 8, 1024, 256      => 1';

# Task 2, Sum of Values
pwc-test './ch-2.raku', <2 5 9 11 3>, 1, 17, 'Sum of Values: @ints = (2, 5, 9, 11, 3), $k = 1 => 17';
pwc-test './ch-2.raku', <2 5 9 11 3>, 2, 11, 'Sum of Values: @ints = (2, 5, 9, 11, 3), $k = 2 => 11';
pwc-test './ch-2.raku', <2 5 9 11 3>, 0,  2, 'Sum of Values: @ints = (2, 5, 9, 11, 3), $k = 0 => 2';
