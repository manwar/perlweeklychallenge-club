#!/usr/bin/env raku

my $n = 2;
my $s = 4;

say(
    (
        (10**($n - 1) ..^ 10**$n)
        .grep(
            {$s == [+] $_.comb})
    ).join(', ')
);
