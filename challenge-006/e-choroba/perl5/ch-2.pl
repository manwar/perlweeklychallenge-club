#! /usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Math::BigFloat;

use constant ACCURACY => 64;

my $r = ('Math::BigFloat'->bpi(ACCURACY)
         * 'Math::BigFloat'->new(163)->bsqrt(ACCURACY)
        )->bexp;
$r->precision(-32);
say $r;
