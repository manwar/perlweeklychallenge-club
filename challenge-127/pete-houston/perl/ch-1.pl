#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12701.pl
#
#        USAGE: ./12701.pl  
#
#  DESCRIPTION: Read 2 sets of integers and output 1 if they are
#               disjoint, 0 otherwise
#
#         BUGS: Not particularly clever.
#        NOTES: The input values can be separated by anything.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 23/08/21
#===============================================================================

use strict;
use warnings;

print "Input the first set of integers on one line:\n";
$_ = <STDIN>;
my %first = map { $_ => 1 } /(-?[0-9]+)/g;

print "Input the second set of integers on one line:\n";
$_ = <STDIN>;
my @matches = grep { $first{$_} } /(-?[0-9]+)/g;

printf "%i\n", $#matches > -1 ? 0 : 1;
