#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7401.pl
#
#        USAGE: ./7401.pl N ...
#
#  DESCRIPTION: Print the majority element in the given array or -1 if none
#
# REQUIREMENTS: POSIX
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 23/08/20
#===============================================================================

use strict;
use warnings;
use POSIX 'ceil';

my %freq;
my $max = -1;
$freq{$_}++ for @ARGV;
my $target = ceil (($#ARGV + 1)/ 2 );
if ($target > keys %freq) {
	($max) = grep { $freq{$_} >= $target } keys %freq;
	$max //= -1;
}
print "$max\n";
