#!/bin/env raku

# The Weekly Challenge 277
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

# Task 1, Count Common
pwc-test './ch-1.raku', 'Perl is my friend', 'Perl and Raku are friend', 2,
    'Count Common: <Perl is my friend>, <Perl and Raku are friend>                        => 2';
pwc-test './ch-1.raku', 'Perl and Python are very similar', 'Python is top in guest languages', 1,
    'Count Common: <Perl and Python are very similar>, <Python is top in guest languages> => 1';
pwc-test './ch-1.raku', 'Perl is imperative Lisp is functional', 'Crystal is similar to Ruby', 0,
    'Count Common: <Perl is imperative Lisp is functional>, <Crystal is similar to Ruby>  => 0';
pwc-test './ch-1a.raku', 'Perl is my friend', 'Perl and Raku are friend', 2,
    'Count Common: <Perl is my friend>, <Perl and Raku are friend>                        => 2';
pwc-test './ch-1a.raku', 'Perl and Python are very similar', 'Python is top in guest languages', 1,
    'Count Common: <Perl and Python are very similar>, <Python is top in guest languages> => 1';
pwc-test './ch-1a.raku', 'Perl is imperative Lisp is functional', 'Crystal is similar to Ruby', 0,
    'Count Common: <Perl is imperative Lisp is functional>, <Crystal is similar to Ruby>  => 0';

# Task 2, Strong Pair
pwc-test './ch-2.raku', <1 2 3 4 5>, 4, 'Strong Pair: 1, 2, 3, 4, 5 => 4';
pwc-test './ch-2.raku', <5 7 1 7>,   1, 'Strong Pair: 5, 7, 1, 7    => 1';
