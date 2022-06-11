#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 15701.pl
#
#        USAGE: ./15701.pl N [ N ... ] 
#
#  DESCRIPTION: Output the three means of the argument list
#
# REQUIREMENTS: List::Util
#        NOTES: Means given to 1DP as per the sample output
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 24/03/22
#===============================================================================

use strict;
use warnings;
use List::Util qw/sum product/;

my $arith = sum (@ARGV) / @ARGV;
my $geom  = (abs product @ARGV) ** (1 / @ARGV);
my $harm  = @ARGV / sum map { 1 / $_ } @ARGV;

printf "AM = %3.1f, GM = %3.1f, HM = %3.1f\n", $arith, $geom, $harm;
