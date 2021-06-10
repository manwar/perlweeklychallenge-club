#!/usr/bin/perl

use strict;
use warnings;
use feature "switch";


#	PART 2
use Math::BigFloat qw(bpi);
my $precision =32;
my $x = bpi($precision)*sqrt(163);
$x->bexp($precision);
print "$x\n";


