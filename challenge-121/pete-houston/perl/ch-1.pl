#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12101.pl
#
#        USAGE: ./12101.pl M N 
#
#  DESCRIPTION: Invert the Nth least significant bit of number M and output.
#
# REQUIREMENTS: Perl 5.10.0 for 'say'
#        NOTES: No input validation - GIGO.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 12/07/21
#===============================================================================

use strict;
use warnings;
use feature 'say';

say $ARGV[0] ^ 2 ** --$ARGV[1];
