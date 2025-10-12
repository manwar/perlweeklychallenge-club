#!perl

require './ch-2.pl';
use Test2::V0;

is max_score('0011'), 4;
is max_score('0000'), 3;
is max_score('1111'), 3;
is max_score('0101'), 3;
is max_score('011101'), 5;
is max_score(''), 0;

done_testing;
