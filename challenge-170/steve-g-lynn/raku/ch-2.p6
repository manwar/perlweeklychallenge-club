#!/usr/bin/raku

use Math::Matrix :ALL;

#--Math::Matrix has a built-in operator for kronecker product
#⊗ or X*
#

my $A = MM [ [1,2], [3,4] ];
my $B = MM [ [5,6], [7,8] ];

say $A ⊗ $B;


