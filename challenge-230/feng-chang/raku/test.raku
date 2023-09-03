#!/bin/env raku

# The Weekly Challenge 230
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Seperate Digits
pwc-test './ch-1.raku', |<1 34 5 6>,   '1 3 4 5 6',     'Seperate Digits: (1, 34, 5, 6)   => 1 3 4 5 6';
pwc-test './ch-1.raku', |<1 24 51 60>, '1 2 4 5 1 6 0', 'Seperate Digits: (1, 24, 51, 60) => 1 2 4 5 1 6 0';

# Task 2, Count Words
pwc-test './ch-2.raku', |<pay attention practice attend>, 'at', 2, '@words = ("pay", "attention", "practice", "attend"), $prefix = "at" => 2';
pwc-test './ch-2.raku', |<janet julia java javascript>,   'ja', 3, '@words = ("janet", "julia", "java", "javascript"),   $prefix = "ja" => 3';

done-testing;
