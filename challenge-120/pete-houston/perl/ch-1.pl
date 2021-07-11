#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12001.pl
#
#        USAGE: ./12001.pl N 
#
#  DESCRIPTION: Swap the odd bits with the even ones.
#
# REQUIREMENTS: N must be an integer between 0 and 255 inclusive
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 05/07/21
#===============================================================================

use strict;
use warnings;

my $n        = shift;
my %masks    = ( even => 0b10101010, odd => 0b01010101 );
my $swapped  = ($n & $masks{even}) / 2 + ($n & $masks{odd}) * 2;

print "$swapped\n";
