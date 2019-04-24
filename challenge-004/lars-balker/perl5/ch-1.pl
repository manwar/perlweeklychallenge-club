use v5.20;
use Math::BigFloat qw/bpi/;
Math::BigFloat->round_mode('zero'); # don't round
say bpi(-s $0);
