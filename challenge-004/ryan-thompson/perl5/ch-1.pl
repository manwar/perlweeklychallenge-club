#!/usr/bin/env perl
#
# ch-1.pl - Display as many digits of pi as there are characters in this file
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;

use bignum qw< bpi >;

say bpi((-s $0) - 2);
