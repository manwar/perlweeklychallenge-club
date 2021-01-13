#!/usr/bin/env perl
#
# ch-2.pl - Calculate Ramanujan's constant (𝑒**(π*sqrt(163)))
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use utf8;

use constant π => 3.14159265359;
use constant 𝑒 => 2.71828182846;

say 𝑒**(π * sqrt(163));
