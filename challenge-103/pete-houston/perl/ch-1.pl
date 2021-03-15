#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 10301.pl
#
#        USAGE: ./10301.pl YEAR
#
#  DESCRIPTION: Output Chinese Zodiac element and animal for given
#               Gregorian year.
#
#        NOTES: All years are assumed to be CE. Zodiac is as at 31st Dec.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 08/03/21
#===============================================================================

use strict;
use warnings;

my @elements = qw/Metal Water Wood Fire Earth/;
my @animals  = qw/Monkey Rooster Dog Pig Rat Ox Tiger Rabbit Dragon Snake Horse Goat/;
my $year     = $ARGV[0];
my $element  = $elements[int ($year / 2) % 5];
my $animal   = $animals[$year % 12];

print "$element $animal\n";
