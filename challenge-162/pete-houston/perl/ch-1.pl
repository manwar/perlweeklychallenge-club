#!/usr/bin/env perl
#===============================================================================
#
#         FILE: 16201.pl
#
#        USAGE: ./16201.pl ISBN 
#
#  DESCRIPTION: Calculate the check digit for the given ISBN
#
# REQUIREMENTS: List::Util (core)
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 25/04/22
#===============================================================================

use strict;
use warnings;
use List::Util qw/sum pairmap/;

my @digits = (my $in = shift) =~ /(\d)/gaa;
my $sum    = sum pairmap { $a + 3 * $b } @digits[0..11];
my $check  = (0 - $sum) % 10;

print "ISBN-13 check digit for '$in' is $check\n";
