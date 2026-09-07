#!/bin/env raku

# The Weekly Challenge 386
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

# Task 1, Reverse Base
pwc-test './ch-1.raku', '101010',  2, 42,        'Reverse Base: $num=101010, $base=2  => 42';
pwc-test './ch-1.raku', 'EEADEE', 16, 15642094,  'Reverse Base: $num=EEADEE, $base=16 => 15642094';
pwc-test './ch-1.raku', '755',     8, 493,       'Reverse Base: $num=755,    $base=8  => 493';
pwc-test './ch-1.raku', '1BRJB',  36, 2228519,   'Reverse Base: $num=1BRJB,  $base=36 => 2228519';
pwc-test './ch-1.raku', '7MyqL',  64, 123456789, 'Reverse Base: $num=7MyqL,  $base=64 => 123456789';

# Task 2, Rational Numbers
pwc-test './ch-2.raku', '0.(12)',   '0.(121)',   'False', 'Rational Numbers: 0.(12)   != 0.(121)';
pwc-test './ch-2.raku', '0.1(23)',  '0.12(32)',  'True',  'Rational Numbers: 0.1(23)  == 0.12(32)';
pwc-test './ch-2.raku', '0.1(234)', '0.12(342)', 'True',  'Rational Numbers: 0.1(234) == 0.12(342)';
pwc-test './ch-2.raku', '12.(9)',   '13.0',      'True',  'Rational Numbers: 12.(9)   == 13.0';
pwc-test './ch-2.raku', '0.(123)',  '0.1(231)',  'True',  'Rational Numbers: 0.(123)  == 0.1(231)';
