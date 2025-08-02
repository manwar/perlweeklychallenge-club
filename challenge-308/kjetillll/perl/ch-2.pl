#https://theweeklychallenge.org/blog/perl-weekly-challenge-308/

use strict; use warnings; use List::Util 'reductions'; use Test::More tests => 2;

sub dx { reverse reductions { $a ^ $b } reverse @_ } #decode xor

is_deeply [ dx( @{$$_{encoded}}, $$_{initial} ) ], $$_{output} for
  { encoded => [1, 2, 3],    initial => 1, output => [1, 0, 2, 1]    },
  { encoded => [6, 2, 7, 3], initial => 4, output => [4, 2, 0, 7, 4] };
