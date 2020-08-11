#!/bin/env perl6

my @a = (0..∞).map:  { sod($_) };
my @b = (0..∞).grep: { @a[$_] > $_ and @a[@a[$_]] == $_ };

say(@b[0], ' ', @a[@b[0]]);

# sum of proper divisors
sub sod(UInt $n) {
    [+] (1 .. $n/2).grep: { $n %% $_ }
}
