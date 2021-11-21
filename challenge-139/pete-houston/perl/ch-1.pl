#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13901.pl
#
#        USAGE: ./13901.pl N N [ N ... ]
#
#  DESCRIPTION: Outputs 1 if the argumentss are numerically sorted ascending,
#               0 otherwise.
#
# REQUIREMENTS: List::MoreUtils 0.430 for slide
#        NOTES: Assumes arguments are numbers
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 15/11/21
#===============================================================================

use strict;
use warnings;
use List::MoreUtils 0.430 qw/slide all/;

my $sorted = 0;
$sorted = 1 if @ARGV < 2 || all { $_ } slide { $a <= $b } @ARGV;
print "$sorted\n";
