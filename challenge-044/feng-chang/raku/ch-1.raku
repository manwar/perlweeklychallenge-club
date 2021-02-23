#!/bin/env raku

use MONKEY-SEE-NO-EVAL;

my @even = 0, 2 ... 16;
my @odd  = 1, 3 ... 15;

([X] (['', '+', '-'] xx 8)).hyper(degree => 12).map({
    my @a;
    @a[@even] = '123456789'.comb;
    @a[@odd] = $_;
    my $s = @a.join;
    put $s if EVAL($s) == 100;
});
