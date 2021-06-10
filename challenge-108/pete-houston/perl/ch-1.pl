#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 10801.pl
#
#        USAGE: ./10801.pl  
#
#  DESCRIPTION: Store a scalar and print the memory address of it
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 12/04/21
#===============================================================================

use strict;
use warnings;

my $scalar = 'foo';
my ($addr) = \$scalar =~ /(0x\w+)/;
print "\$scalar is at memory address $addr\n";
