#!/usr/bin/perl

use strict;
use warnings;

use Math::Base36 ':all'; 

my $number = $ARGV[0] || 10;

my $b36 = encode_base36($number);

print "Decimal:$number -> Base36:$b36\n";
