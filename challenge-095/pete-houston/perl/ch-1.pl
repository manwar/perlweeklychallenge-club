#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9501.pl
#
#        USAGE: ./9501.pl N 
#
#  DESCRIPTION: Print 1 if the number N is palindromic, 0 otherwise
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 11/01/21
#===============================================================================

use strict;
use warnings;

my $n = shift;
print $n eq reverse ("$n") ? "1\n" : "0\n";
