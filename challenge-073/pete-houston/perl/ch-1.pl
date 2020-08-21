#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7301.pl
#
#        USAGE: ./7301.pl SIZE N ...
#
#  DESCRIPTION: Given a window size and a list of ints, print the list
#               of minima in each window.
#
# REQUIREMENTS: List::Util (core)
#        NOTES: Should work equally well with floats
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 13/08/20
#===============================================================================

use strict;
use warnings;
use List::Util 'min';

my ($size, @a) = @ARGV;
die "Size is bigger than array" if $size > @a;

my (@win, @mins);
(@win[0..$size-1], @a) = (undef, @a);

while ($#a > -1) {
	shift @win;
	push @win, shift @a;
	push @mins, min (@win);
}
print "@mins\n";
