#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 15902.pl
#
#        USAGE: ./15902.pl N 
#
#  DESCRIPTION: Output the Möbius number for N
#
# REQUIREMENTS: Math::Prime::Util
#        NOTES: It is amazing how simple Perl with Math::Prime::UTil
#               makes this.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 06/04/22
#===============================================================================

use strict;
use warnings;
use feature 'say';

use Math::Prime::Util 'moebius';

say moebius shift;
