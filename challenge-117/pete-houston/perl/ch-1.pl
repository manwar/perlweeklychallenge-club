#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11701.pl
#
#        USAGE: ./11701.pl INFILE 
#
#  DESCRIPTION: Find the missing numbered row out of 15 in INFILE
#
# REQUIREMENTS: Path::Tiny
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 14/06/21
#===============================================================================

use strict;
use warnings;
use Path::Tiny;

my %rows = map { $_ => 1 } 1..15;
delete $rows{$_} for map { s/,.*$//; $_ } path (shift)->lines ({ chomp => 1});
my ($missing) = keys %rows;
print "Row $missing is missing\n";
