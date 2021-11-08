#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11602.pl
#
#        USAGE: ./11602.pl N
#
#  DESCRIPTION: Is the sum of the squares of the digits a square? 1 for
#               yes, 0 for no.
#
# REQUIREMENTS: List::Util (core)
#        NOTES: N must be a decimal integer greater than 9
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 07/06/21
#===============================================================================

use strict;
use warnings;
use List::Util 'sum';

my $root = sqrt sum map { $_ * $_ } split //, shift;
print $root == int $root ? "1\n" : "0\n";
