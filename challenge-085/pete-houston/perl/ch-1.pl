#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8501.pl
#
#        USAGE: ./8501.pl N1 N2 ...
#
#  DESCRIPTION: Given an array of positive floats determine if a sum
#  of any three of them may fall between 1 and 2
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 04/11/20
#===============================================================================

use strict;
use warnings;

my $ge = 1;
my $lt = 2;
my @valid = grep { $_ < $lt } @ARGV;
if ($#valid < 2) {
	print "0\n";
	exit;
}

find_sum (3, $ge, $lt, @valid);
print "0\n";

sub find_sum {
	my ($count, $ge, $lt, @num) = @_;
	if ($count < 2) {
		my $res = grep { $_ >= $ge && $_ < $lt } @num;
		if ($res) {
			print "1\n";
			exit;
		}
		return;
	}
	for my $i (0 .. $#num) {
		my $diff = $num[$i];
		my @new  = @num;
		splice (@new, $i, 1);
		find_sum ($count - 1, $ge - $diff, $lt - $diff, @new);
	}
}
