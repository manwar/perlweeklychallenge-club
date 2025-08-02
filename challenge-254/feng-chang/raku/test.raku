#!/bin/env raku

# The Weekly Challenge 254
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

# Task 1, Three Power
pwc-test './ch-1.raku', 27, 'True',  '27 = 3³';
pwc-test './ch-1.raku', 0,  'True',  '0 = 0³';
pwc-test './ch-1.raku', 6,  'False', '6 is not a power of 3';

# Task 2, Reverse Vowels
pwc-test './ch-2.raku', 'Raku',  'Ruka',  'Reverse Vowels: Raku  => Ruka';
pwc-test './ch-2.raku', 'Perl',  'Perl',  'Reverse Vowels: Perl  => Perl';
pwc-test './ch-2.raku', 'Julia', 'Jaliu', 'Reverse Vowels: Julia => Jaliu';
pwc-test './ch-2.raku', 'Uiua',  'Auiu',  'Reverse Vowels: Uiua  => Auiu';

done-testing;
