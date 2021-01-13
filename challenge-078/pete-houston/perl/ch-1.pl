#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7801.pl
#
#        USAGE: ./7801.pl N ...
#
#  DESCRIPTION: Output a list of all elements greater than those which
#               follow
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 15/09/20
#===============================================================================

use strict;
use warnings;

my $max = $ARGV[-1] - 1;
my @out = reverse grep { $_ > $max and $max = $_, 1 } reverse @ARGV;
print "@out\n";
