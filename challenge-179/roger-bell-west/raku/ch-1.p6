#! /usr/bin/perl6

use Lingua::EN::Numbers;

use Test;

plan 3;

is(ordinal(11),"eleventh",'example 1');
is(ordinal(62),"sixty-second",'example 2');
is(ordinal(99),"ninety-ninth",'example 3');
