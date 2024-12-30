#!perl

require './ch-2.pl';

use Test2::V0;

is hamming(4, 14), 2;
is hamming(2, 14), 2;
is hamming(4,  2), 2;

is hamming_multi(4, 14, 2), 6;
is hamming_multi(4, 14, 4), 4;

done_testing;

