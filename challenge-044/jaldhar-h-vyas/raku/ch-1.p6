#!/usr/bin/perl6
use MONKEY-SEE-NO-EVAL;

my @digits = 1 .. 9;
my @ops = (' + ', ' - ', q{});

say "$_ = 100" for
    (([X] @ops xx 8) X q{})
    ==> map({ (@digits Z~ @_).join; })
    ==> grep({ EVAL($_) == 100; });
