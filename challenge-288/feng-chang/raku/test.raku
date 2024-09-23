#!/bin/env raku

# The Weekly Challenge 288
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

# Task 1, Closest Palindrome
pwc-test './ch-1.raku',  123,  121, 'Closest Palindrome:  123 => 121';
pwc-test './ch-1.raku',    2,    1, 'Closest Palindrome:    2 => 1';
pwc-test './ch-1.raku', 1400, 1441, 'Closest Palindrome: 1400 => 1441';
pwc-test './ch-1.raku', 1001,  999, 'Closest Palindrome: 1001 => 999';

# Task 2, Contiguous Block
pwc-test './ch-2.raku', 'in01.txt', 11, 'Contiguous Block: in01.txt => 11';
pwc-test './ch-2.raku', 'in02.txt', 11, 'Contiguous Block: in02.txt => 11';
pwc-test './ch-2.raku', 'in03.txt', 7,  'Contiguous Block: in03.txt => 7';
