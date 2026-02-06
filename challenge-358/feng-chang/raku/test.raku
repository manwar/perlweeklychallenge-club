#!/bin/env raku

# The Weekly Challenge 358
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

# Task 1, Max Str Value
pwc-test './ch-1.raku', <123 45 6>,            123, 'Max Str Value: 123,45,6           =>  123';
pwc-test './ch-1.raku', <abc de fghi>,           4, 'Max Str Value: abc,de,fghi        =>    4';
pwc-test './ch-1.raku', <0012 99 a1b2c>,        99, 'Max Str Value: 0012,99,a1b2c      =>   99';
pwc-test './ch-1.raku', <x 10 xyz 007>,         10, 'Max Str Value: x,10,xyz,007       =>   10';
pwc-test './ch-1.raku', <hello123 2026 perl>, 2026, 'Max Str Value: hello123,2026,perl => 2026';

# Task 2, Encrypted String
pwc-test './ch-2.raku', 'abc',   1, 'bcd',   'Encrypted String: abc,1   => bcd';
pwc-test './ch-2.raku', 'xyz',   2, 'zab',   'Encrypted String: xyz,2   => zab';
pwc-test './ch-2.raku', 'abc',  27, 'bcd',   'Encrypted String: abc,27  => bcd';
pwc-test './ch-2.raku', 'hello', 5, 'mjqqt', 'Encrypted String: hello,5 => mjqqt';
pwc-test './ch-2.raku', 'perl', 26, 'perl',  'Encrypted String: perl,26 => perl';
