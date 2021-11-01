#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13601.pl
#
#        USAGE: ./13601.pl N M
#
#  DESCRIPTION: Two-Friendly numbers
#
# REQUIREMENTS: Math::Prime::Util, Perl 5.10
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 30/10/21
#===============================================================================

use strict;
use warnings;
use feature 'say';
use Math::Prime::Util 'gcd';

my $gcd = gcd (@ARGV[0,1]);
my $l2  = log ($gcd) / log (2);

say $l2 == int ($l2) ? 1 : 0;
