#!/bin/env raku

# The Weekly Challenge 220
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Common Characters
pwc-test './ch-1.raku', |<Perl Rust Raku>,  'r',       'Common Characters: Perl, Rust, Raku  => r';
pwc-test './ch-1.raku', |<love live leave>, 'e, l, v', 'Common Characters: love, live, leave => e, l, v';

# Task 2, Squareful
pwc-test './ch-2.raku', |<1 17 8>, "1, 8, 17\n17, 8, 1", 'Squareful: (1, 17, 8) => (1, 8, 17), (17, 8, 1)';
pwc-test './ch-2.raku', |<2 2 2>,  '2, 2, 2',            'Squareful: (2, 2, 2)  => (2, 2, 2)';

done-testing;
