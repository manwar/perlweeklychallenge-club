#!/bin/env raku

# The Weekly Challenge 359
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

# Task 1, Digital Root
pwc-test './ch-1.raku', 38,         "Persistance  = 2\nDigital Root = 2", 'Digital Root: 38         => 2,2';
pwc-test './ch-1.raku', 7,          "Persistance  = 0\nDigital Root = 7", 'Digital Root: 7          => 0,7';
pwc-test './ch-1.raku', 999,        "Persistance  = 2\nDigital Root = 9", 'Digital Root: 999        => 2,9';
pwc-test './ch-1.raku', 1999999999, "Persistance  = 3\nDigital Root = 1", 'Digital Root: 1999999999 => 3,1';
pwc-test './ch-1.raku', 101010,     "Persistance  = 1\nDigital Root = 3", 'Digital Root: 101010     => 1,3';

# Task 2, String Reduction
pwc-test './ch-2.raku', 'aabbccdd',    '',       'String Reduction: aabbccdd    => ""';
pwc-test './ch-2.raku', 'abccba',      '',       'String Reduction: abccba      => ""';
pwc-test './ch-2.raku', 'abcdef',      'abcdef', 'String Reduction: abcdef      => abcdef';
pwc-test './ch-2.raku', 'aabbaeaccdd', 'aea',    'String Reduction: aabbaeaccdd => aea';
pwc-test './ch-2.raku', 'mississippi', 'm',      'String Reduction: mississippi => m';
