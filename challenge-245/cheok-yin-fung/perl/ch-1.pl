# The Weekly Challenge 245
# Task 1 Sort Language
use v5.30.0;
use warnings;

sub sl {
    my @lang = $_[0]->@*;
    my @pop = $_[1]->@*;
    my @nlang = map { $lang[$_] } sort { $pop[$a] <=> $pop[$b] } 0..$#lang;
    return [@nlang];
}

use Test::More tests=>2;
use Test::Deep;
cmp_deeply sl(['perl','c','python'],[2,1,3]), ['c','perl','python'];
cmp_deeply sl(['c++','haskell','java'],[1,3,2]), ['c++','java','haskell'];
