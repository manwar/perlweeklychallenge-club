#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12201.pl
#
#        USAGE: ./12201.pl N N [ N ] ... 
#
#  DESCRIPTION: Stream average - output the average of all numbers so
#               far as a list.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 19/07/21
#===============================================================================

use strict;
use warnings;

my $sum = 0;
my $num = 1;

my @avg = map { $sum += $_; $sum/$num++ } @ARGV;
print "@avg\n";
