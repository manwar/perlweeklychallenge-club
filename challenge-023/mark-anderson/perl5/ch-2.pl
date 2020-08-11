#!/usr/bin/env perl

use Modern::Perl      '2018';
use Math::Prime::Util 'factor';

my $num = shift || 228;
say join ", ", factor($num);
