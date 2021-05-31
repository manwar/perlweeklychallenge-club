#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11401.pl
#
#        USAGE: ./11401.pl N 
#
#  DESCRIPTION: Output the next palindromic number above natural number N
#
# REQUIREMENTS: POSIX
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 24/05/21
#===============================================================================

use strict;
use warnings;
use POSIX 'ceil';

my $n = shift;

my $digits  = length $n;
my $halflen = ceil $digits / 2;

my $pal = palindrome ($n, $digits, $halflen);
if ($pal <= $n) {
	# Not high enough so increment the first half and try again
	$pal = substr ($pal, 0, $halflen) + 1 . substr ($pal, $halflen);
	# Bump the digits and halflength if the number is now longer
	if ($digits < length $pal) {
		$digits++;
		$halflen = ceil $digits / 2;
	}
	$pal = palindrome ($pal, $digits, $halflen);
}
print "$pal\n";


sub palindrome {
	my ($num, $d, $halfl) = @_;

	# Set the length of the reverse part
	my $revlen = $d % 2 ? $halfl - 1 : $halfl;
	# Create the palindrome based on the first half
	substr $num, $halfl, $d - $halfl, reverse substr $num, 0, $revlen;
	return $num;
}
