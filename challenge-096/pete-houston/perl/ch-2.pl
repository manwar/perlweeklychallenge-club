#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9602.pl
#
#        USAGE: ./9602.pl STRING1 STRING2
#
#  DESCRIPTION: Output the Levenshtein distance between the 2 strings
#
# REQUIREMENTS: Text::Levenshtein
#         BUGS: See the POD of Text::Levenshtein for some caveats
#        NOTES: CPAN is Perl's secret weapon and makes this task trivial
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 18/01/21
#===============================================================================

use strict;
use warnings;
use Text::Levenshtein 'distance'; # CPAN is awesome

die "Usage: $0 STRING1 STRING2\n" unless 2 == @ARGV;
print distance(@ARGV) . "\n";
