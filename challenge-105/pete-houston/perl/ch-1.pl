#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 10501.pl
#
#        USAGE: ./10501.pl ROOT OPERAND
#
#  DESCRIPTION: Display the ROOTth root of OPERAND
#
#        NOTES: This sems trivial. Have I missed something?
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 27/03/21
#===============================================================================

use strict;
use warnings;

my ($n, $k) = @ARGV;
die "Root ($n) must be more than 1\n" unless $n > 1;
die "Operand ($k) must be positive\n" unless $k > 0;
print $k ** (1 / $n) . "\n";
