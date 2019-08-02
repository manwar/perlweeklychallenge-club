use strict;
use warnings;
use feature "say";
use Math::BigFloat "bpi";
say Math::BigFloat->new(163)->bsqrt->bmul(bpi)->bexp(32);
