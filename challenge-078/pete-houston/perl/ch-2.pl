#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7802.pl
#
#        USAGE: ./7802.pl  
#
#  DESCRIPTION: Array rotations
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 15/09/20
#===============================================================================

use strict;
use warnings;

my ($arr, $ind) = get_inputs ();
my $res = rotate_arrays ($arr, $ind);
print "[@$_]\n" for @$res;

sub rotate_arrays {
	my ($arr, $ind) = @_;
	my @aoa;
	push @aoa, [@$arr[$_..$#$arr,0..$_-1]] for @$ind;
	return \@aoa;
}

sub get_inputs {
	print "Enter your array on one line: ";
	chomp (my @arr = split / /, <STDIN>);
	print "Enter your list of starting points on one line: ";
	my @ind = split / /, <STDIN>;
	return (\@arr, \@ind);
}
