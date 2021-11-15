#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13802.pl
#
#        USAGE: ./13802.pl N
#
#  DESCRIPTION: Given a square N, output 1 if the root can be a sum of 2
#               or more "splits" of N.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 08/11/21
#===============================================================================

use strict;
use warnings;

my $n    = shift;
my $root = sqrt $n;
my $len  = length $n;

print 0 + can_sum ($root, $n, 0) . "\n";

sub can_sum {
	my ($tot, $str, $subtot) = @_;
	return 1 if $subtot + $str == $tot;
	my $len = length ($str);
	for my $i (1 .. $len - 1) {
		my ($start, $rest) = $str =~ /^(\d{$i})(.*)$/;
		return 1 if can_sum ($tot, $rest, $subtot + $start);
	}
	return 0;
}
