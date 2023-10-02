#!/bin/env raku

# The Weekly Challenge 224
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Special Notes
pwc-test './ch-1.raku', |<abc xyz>,                'False', 'Special Notes: $source = "abc",               $target = "xyz"  => False';
pwc-test './ch-1.raku', |<scriptinglanguage perl>,  'True', 'Special Notes: $source = "scriptinglanguage", $target = "perl" => True';
pwc-test './ch-1.raku', |<aabbcc abc>,              'True', 'Special Notes: $source = "aabbcc",            $target = "abc"  => True';

# Task 2, Additive Number
pwc-test './ch-2.raku', 112358,    'true', 'Additive Number: 112358    => true';
pwc-test './ch-2.raku', 12345,    'false', 'Additive Number:  12345    => false';
pwc-test './ch-2.raku', 199100199, 'true', 'Additive Number: 199100199 => true';

done-testing;
