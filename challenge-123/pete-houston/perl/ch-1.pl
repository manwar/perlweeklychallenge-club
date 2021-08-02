#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12301.pl
#
#        USAGE: ./12301.pl N 
#
#  DESCRIPTION: Output the Nth ugly number.
#
# REQUIREMENTS: Math::Prime::Util, List::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 26/07/21
#===============================================================================

use strict;
use warnings;
use Math::Prime::Util 'factor';
use List::Util 'any';

my ($n, $i, $j) = (shift, 0, 0);
do {
	$i++ unless any { $_ != 2 && $_ != 3 && $_ != 5 } factor (++$j);
} until $i == $n;

print "$j\n";
