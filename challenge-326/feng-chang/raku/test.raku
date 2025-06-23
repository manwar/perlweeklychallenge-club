#!/bin/env raku

# The Weekly Challenge 326
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

# Task 1, Day of the Year
pwc-test './ch-1.raku', '2025-02-02',  33, 'Day of the Year: 2025-02-02 =>  33';
pwc-test './ch-1.raku', '2025-04-10', 100, 'Day of the Year: 2025-04-10 => 100';
pwc-test './ch-1.raku', '2025-09-07', 250, 'Day of the Year: 2025-09-07 => 250';

# Task 2, Decompressed List
pwc-test './ch-2.raku', <1 3 2 4>, '3 4 4',       'Decompressed List: 1,3,2,4 => 3,4,4';
pwc-test './ch-2.raku', <1 1 2 2>, '1 2 2',       'Decompressed List: 1,1,2,2 => 1,2,2';
pwc-test './ch-2.raku', <3 1 3 2>, '1 1 1 2 2 2', 'Decompressed List: 3,1,3,2 => 1,1,1,2,2,2';
