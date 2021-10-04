#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13201.pl
#
#        USAGE: ./13201.pl YYYY/MM/DD [ REF_DATE ]
#
#  DESCRIPTION: For the given date of birth, display the DoB of someone
#               who would have been your age now on your birthday and
#               the date at which someone born today would have your age
#               now.
#
#      OPTIONS: If REF_DATE is supplied use that as reference point
#               instead of today.
# REQUIREMENTS: Time::Piece 1.31_01 (for truncate)
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 27/09/21
#===============================================================================

use strict;
use warnings;
use Time::Piece 1.31_01;

my $dob = Time::Piece->strptime (shift, '%Y/%m/%d');

my $today =
	scalar @ARGV ?
	Time::Piece->strptime (shift, '%Y/%m/%d') :
	localtime;

my $diff = $today->truncate (to => 'day') - $dob;
die "Date supplied (" . $dob->ymd . ") is in the future.\n" if $diff < 0;

my $past   = $dob - $diff;
my $future = $today + $diff;
print $past->ymd ('/') . ' ' . $future->ymd ('/') . "\n";
