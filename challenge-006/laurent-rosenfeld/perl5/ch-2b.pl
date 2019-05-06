use strict;
use warnings;
use Math::BigFloat "bpi";
my $sqrt_163 = Math::BigFloat->new(163)->bsqrt;
my $big_e =  Math::BigFloat->new(1)->bexp;
printf "%.33s\n", $big_e ** (bpi() * $sqrt_163);
