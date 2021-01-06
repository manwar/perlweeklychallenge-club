#!/bin/env raku

use MONKEY-SEE-NO-EVAL;

my @even = 0, 2 ... 16;
my @odd  = 1, 3 ... 15;

my @a;
@a[@even] = '123456789'.comb».UInt;

for [X] (['', '+', '-'] xx 8) -> @ops {
    @a[@odd] = @ops;
    my $s = @a.join;
    put $s if EVAL($s) == 100;
}
