#!/bin/env raku

# The Weekly Challenge 319
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

# Task 1, Word Count
pwc-test './ch-1.raku', <unicode xml raku perl>, 2, 'Word Count: "unicode","xml","raku","perl" => 2';
pwc-test './ch-1.raku', <the weekly challenge>,  2, 'Word Count: "the","weekly","challenge"    => 2';
pwc-test './ch-1.raku', <perl python postgres>,  0, 'Word Count: "perl","python","postgres"    => 0';

# Task 2, Minimum Common
pwc-test './ch-2.raku', '1,2,3,4', '3,4,5,6',  3, 'Minimum Common: (1,2,3,4), (3,4,5,6) =>  3';
pwc-test './ch-2.raku', '1,2,3',   '2,4',      2, 'Minimum Common: (1,2,3),   (2,4)     =>  2';
pwc-test './ch-2.raku', '1,2,3,4', '5,6,7,8', -1, 'Minimum Common: (1,2,3,4), (5,6,7,8) => -1';
