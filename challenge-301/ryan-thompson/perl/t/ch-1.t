#!perl

require './ch-1.pl';

use Test2::V0;

is largest(),               0,                          'Empty set';
is largest(1),              1,                          'Single';
is largest(20,3),           320;
is largest(3,30,34,5,9),    9534330;
is largest(50, 5, 501, 51), 55150501;
is largest(1,10,11,110,20,2,202,220,211,210,2110),
                            '222021121102102022011011101';
is largest(1..16),          '98765432161514131211101',  '1..16';
is largest(1, 10, 110, 1110, 11110),
                            '111110111011010';
done_testing;
