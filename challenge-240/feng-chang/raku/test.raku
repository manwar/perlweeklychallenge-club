#!/bin/env raku

# The Weekly Challenge 240
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

# Task 1, Acronym
pwc-test './ch-1.raku', |<Perl Python Pascal>, 'ppp', 'True',  'Acronym: @str = "Perl", "Python", "Pascal", $chk = "ppp" => True';
pwc-test './ch-1.raku', |<Perl Raku>,          'rp',  'False', 'Acronym: @str = "Perl", "Raku",             $chk = "rp"  => False';
pwc-test './ch-1.raku', |<Oracle Awk C>,       'oac', 'True',  'Acronym: @str = "Oracle", "Awk", "C",       $chk = "oac" => True';

# Task 2, Build Array
pwc-test './ch-2.raku', |<0 2 1 5 3 4>, '0 1 2 4 5 3', 'Build Array: (0, 2, 1, 5, 3, 4) => "0 1 2 4 5 3"';
pwc-test './ch-2.raku', |<5 0 1 2 3 4>, '4 5 0 1 2 3', 'Build Array: (5, 0, 1, 2, 3, 4) => "4 5 0 1 2 3"';

done-testing;
