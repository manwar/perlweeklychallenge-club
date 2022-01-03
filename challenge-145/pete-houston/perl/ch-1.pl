#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14501.pl
#
#        USAGE: ./14501.pl  
#
#  DESCRIPTION: Read 2 arrays from STDIN and output the scalar product.
#
# REQUIREMENTS: List::Util, List::MoreUtils
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 30/12/21
#===============================================================================

use strict;
use warnings;
use List::Util qw/sum/;
use List::MoreUtils qw/pairwise/;

my (@x, @y);
get_inputs (\@x, \@y);

my $prod = dot_product (\@x, \@y);

print "$prod\n";

sub get_inputs {
	my ($first, $second) = @_;
	for my $aref ($first, $second) {
		print "Enter one value per line and finish with empty line:\n";
		while ($_ = <STDIN>) {
			last if /^$/;
			push @$aref, $_;
		}
		chomp @$aref;
	}
	die "Arrays have different lengths\n" unless $#$first == $#$second;
}

sub dot_product {
	my ($x, $y) = @_;
	return sum pairwise { $a * $b } @$x, @$y;
}
