#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12501.pl
#
#        USAGE: ./12501.pl N
#
#  DESCRIPTION: Given a positive integer, print all unique Pythagorean
#               triples in which it features, or just "-1" if there are none.
#
# REQUIREMENTS: Math::Prime::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 09/08/21
#===============================================================================

use strict;
use warnings;
use Math::Prime::Util qw/is_square/;

my $n  = shift;
my $n2 = $n * $n;

# Avoid duplicates, so store them in a hash keyed on either of the other
# members of the triple.
my %triples;

# n squared could be the sum of 2 squares or the difference of 2 squares

# Sum. Count downwards from n.
my $go = $n;
while (--$go > 4) {
	next if exists $triples{$go};
	my $sqdiff = $n2 - $go * $go;
	store_if_sq (\%triples, $sqdiff, $n, $go);
}

# Difference. Count upwards from n.
$go = $n;
my $oldgo2 = $n2;
while (1) {
	my $go2 = ++$go * $go;
	last if $n2 < ($go2 - $oldgo2);
	my $sqdiff = $go2 - $n2;
	store_if_sq (\%triples, $sqdiff, $n, $go);
	$oldgo2 = $go2;
}

unless (scalar keys %triples) {
	print "-1\n";
	exit;
}

print "(@$_)\n" for values %triples;

sub store_if_sq {
	my ($tri, $sqdiff, @rest) = @_;
	return unless is_square ($sqdiff);
	my $diff = sqrt $sqdiff;
	$tri->{$diff} = [$diff, @rest];
}
