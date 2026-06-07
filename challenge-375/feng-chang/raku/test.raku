#!/bin/env raku

# The Weekly Challenge 375
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

# Task 1, Single Common Word
pwc-test './ch-1.raku', '<apple banana cherry>', '<banana cherry date>', 2, 'Single Common Word: @array1=<apple banana cherry>, @array2=<banana cherry date> => 2';
pwc-test './ch-1.raku', '<a ab abc>', '<a a ab abc>',                    2, 'Single Common Word: @array1=<a ab abc>,            @array2=<a a ab abc>         => 2';
pwc-test './ch-1.raku', '<orange lemon>', '<grape melon>',               0, 'Single Common Word: @array1=<orange lemon>,        @array2=<grape melon>        => 0';
pwc-test './ch-1.raku', '<test test demo>', '<test demo demo>',          0, 'Single Common Word: @array1=<test test demo>,      @array2=<test demo demo>     => 0';
pwc-test './ch-1.raku', '<Hello world>', '<hello world>',                1, 'Single Common Word: @array1=<Hello world>,         @array2=<hello world>        => 1';

# Task 2, Find K-Beauty
pwc-test './ch-2.raku', 240,  2, 2, 'Find K-Beauty: $num=240, $k=2 => 2';
pwc-test './ch-2.raku', 1020, 2, 3, 'Find K-Beauty: $num=1020,$k=2 => 3';
pwc-test './ch-2.raku', 444,  2, 0, 'Find K-Beauty: $num=444, $k=2 => 0';
pwc-test './ch-2.raku', 17,   2, 1, 'Find K-Beauty: $num=17,  $k=2 => 1';
pwc-test './ch-2.raku', 123,  1, 2, 'Find K-Beauty: $num=123, $k=1 => 2';
