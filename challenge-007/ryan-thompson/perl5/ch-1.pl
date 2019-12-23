#!/usr/bin/env perl
#
# ch-1.pl - Niven numbers
#
# 2019 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use List::Util 'sum';

say for grep { $_ % (sum split '') == 0 } 1..50;
