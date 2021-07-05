#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11901.pl
#
#        USAGE: ./11901.pl [ N ]
#
#  DESCRIPTION: Swap the nybbles and output the decimal.
#
#      OPTIONS: If N is omitted, run the test suite instead
# REQUIREMENTS: Bit::Manip, Test::More
#        NOTES: If N is given but not a small whole number an error is thrown.
#               Either swap subroutine could be used as the main one or the
#               test one in reality, of course.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 28/06/21
#===============================================================================

use strict;
use warnings;
use Bit::Manip qw/bit_get bit_set/;
use Test::More;

if (scalar @ARGV) {
	my $n = valid_input ();
	print 0+nybble_swap ($n) . "\n";
	exit;
}

plan tests => 256;
for my $i (1 .. 255, 0) {
	is nybble_swap ($i), check_swap ($i),
		"$i swaps match to " .  nybble_swap ($i);
}

sub valid_input {
	my ($input) = $ARGV[0] =~ /^([0-9][0-9]*)$/
		or die "Argument must be positive int\n";
	die "Input must be less than 256" if $input >= 256;
	return $input;
}

sub nybble_swap {
	my $byte   = shift;
	my $nybble = bit_get ($byte, 7, 4);
	$byte = bit_set ($byte, 4, 4, bit_get ($byte, 3, 0));
	$byte = bit_set ($byte, 0, 4, $nybble);
	return $byte;
}

sub check_swap {
	my $num   = shift;
	my $upper = int $num / 16;
	my $lower = $num % 16;
	return $lower * 16 + $upper;
}
