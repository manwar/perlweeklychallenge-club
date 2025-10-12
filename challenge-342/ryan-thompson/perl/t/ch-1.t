#!perl

use v5.38;

require './ch-1.pl';

use Test2::V0;

is balanced('a0b1c2'), '0a1b2c';
is balanced('abc12'),  'a1b2c';
is balanced('0a2b1c3'),'0a1b2c3';
is balanced('1a23'),   '';
is balanced('ab123'),  '1a2b3';
is balanced($_), $_ for '', '1', 'a';
is balanced('unbalanced123'), '';
ok dies { balanced('ab!12') };

done_testing;
