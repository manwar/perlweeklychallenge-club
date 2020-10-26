#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8301.pl
#
#        USAGE: ./8301.pl "string"
#
#  DESCRIPTION: Given a string with 3 or more words, display the number
#  of non-space characters excepting the first and last words.
#
#        NOTES: Assumes whitespace is just space, tab and linefeed
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 19/10/20
#===============================================================================

use strict;
use warnings;

my ($str) = $ARGV[0] =~ /^\S*(.*?)\S*$/s; # Drop first and last words
my $charcount = $str =~ tr/ \011\012//c;  # Count non-whitespace remaining
print "$charcount\n";                     # Result
