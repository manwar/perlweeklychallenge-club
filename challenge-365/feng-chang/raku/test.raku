#!/bin/env raku

# The Weekly Challenge 365
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

# Task 1, Alphabet Index Digit Sum
pwc-test './ch-1.raku', <abc  1>, 6, 'Alphabet Index Digit Sum: abc  1 => 6';
pwc-test './ch-1.raku', <az   2>, 9, 'Alphabet Index Digit Sum: az   2 => 9';
pwc-test './ch-1.raku', <cat  1>, 6, 'Alphabet Index Digit Sum: cat  1 => 6';
pwc-test './ch-1.raku', <dog  2>, 8, 'Alphabet Index Digit Sum: dog  2 => 8';
pwc-test './ch-1.raku', <perl 3>, 6, 'Alphabet Index Digit Sum: perl 3 => 6';

# Task 2, Valid Token Counter
pwc-test './ch-2.raku', <cat and dog>,              3, 'Valid Token Counter: cat and dog              => 3';
pwc-test './ch-2.raku', <a-b c! d,e>,               2, 'Valid Token Counter: a-b c! d,e               => 2';
pwc-test './ch-2.raku', <hello-world! this is fun>, 4, 'Valid Token Counter: hello-world! this is fun => 4';
pwc-test './ch-2.raku', <ab- cd-ef gh- ij!>,        2, 'Valid Token Counter: ab- cd-ef gh- ij!        => 2';
pwc-test './ch-2.raku', <wow! a-b-c nice.>,         2, 'Valid Token Counter: wow! a-b-c nice.         => 2';
