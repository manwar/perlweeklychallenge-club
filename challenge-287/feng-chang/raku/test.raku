#!/bin/env raku

# The Weekly Challenge 287
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

# Task 1, Strong Password
pwc-test './ch-1.raku', 'a',         5, 'Strong Password: a         => 5';
pwc-test './ch-1.raku', 'aB2',       3, 'Strong Password: aB2       => 3';
pwc-test './ch-1.raku', 'PaaSW0rd',  0, 'Strong Password: PaaSW0rd  => 0';
pwc-test './ch-1.raku', 'Paaasw0rd', 1, 'Strong Password: Paaasw0rd => 1';
pwc-test './ch-1.raku', 'aaaaa',     2, 'Strong Password: aaaaa     => 2';

pwc-test './ch-1a.raku', 'a',         5, 'Strong Password: a         => 5';
pwc-test './ch-1a.raku', 'aB2',       3, 'Strong Password: aB2       => 3';
pwc-test './ch-1a.raku', 'PaaSW0rd',  0, 'Strong Password: PaaSW0rd  => 0';
pwc-test './ch-1a.raku', 'Paaasw0rd', 1, 'Strong Password: Paaasw0rd => 1';
pwc-test './ch-1a.raku', 'aaaaa',     2, 'Strong Password: aaaaa     => 2';

# Task 2, Valid Number
pwc-test './ch-2.raku', '--', '1',       'True',  'Valid Number: 1       => true';
pwc-test './ch-2.raku', '--', 'a',       'False', 'Valid Number: a       => false';
pwc-test './ch-2.raku', '--', '.',       'False', 'Valid Number: .       => false';
pwc-test './ch-2.raku', '--', '1.2e4.2', 'False', 'Valid Number: 1.2e4.2 => false';
pwc-test './ch-2.raku', '--', '-1.',     'True',  'Valid Number: -1.     => true';
pwc-test './ch-2.raku', '--', '+1E-8',   'True',  'Valid Number: +1E-8   => true';
pwc-test './ch-2.raku', '--', '.44',     'True',  'Valid Number: .44     => true';
pwc-test './ch-2.raku', '--', '.44e5',   'False', 'Valid Number: .44e5   => false';
