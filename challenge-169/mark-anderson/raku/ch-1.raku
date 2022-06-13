#!/usr/bin/env raku

use Test;

is-deeply brilliant[^20], (4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169, 187, 209, 221, 247, 253, 289, 299);

is-deeply brilliant[990..999], (50429, 50467, 50573, 50621, 50629, 50657, 50689, 50693, 50737, 50759);

is-deeply brilliant[9990..9999], (694151, 694691, 694921, 694931, 695027, 695273, 695399, 695531, 695683, 696191);

multi brilliant { (1, 10, 100...*).map(&brilliant).flat }

multi brilliant(\n)
{
    my \primes = (n..^n*10).grep(&is-prime).List;
    sort unique primes X* primes
}
