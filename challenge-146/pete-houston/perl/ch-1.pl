#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14601.pl
#
#        USAGE: ./14601.pl [ N ] 
#
#  DESCRIPTION: Output the Nth prime (defaults to 10001)
#
#      OPTIONS: N defaults to 10_001 if unspecified
# REQUIREMENTS: Math::Prime::Util, what else?
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 05/01/22
#===============================================================================

use strict;
use warnings;
use Math::Prime::Util 'nth_prime';

print nth_prime (shift // 10_001) . "\n";
