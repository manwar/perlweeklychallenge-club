#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13502.pl
#
#        USAGE: ./13502.pl [-s] SEDOL [ SEDOL ... ] 
#
#  DESCRIPTION: Print 1 for each argument that is a valid SEDOL, 0
#               otherwise. https://en.wikipedia.org/wiki/SEDOL
#
#      OPTIONS: -s checks that the first character is a letter as per
#               the wikipedia article.
# REQUIREMENTS: Getopt::Long::Modern
#        NOTES: This is an already-solved problem: see Business::SEDOL.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 18/10/21
#===============================================================================

use strict;
use warnings;
use Getopt::Long::Modern;

GetOptions (s => \my $strict);
print '' . valid_sedol (uc $_, $strict) . "\n" for @ARGV;

sub valid_sedol {
	my ($code, $s) = @_;
	return 0 unless 7 == length ($code) && $code =~ /^[0-9B-DF-HJ-NP-TV-Z]+$/;
	my @chars = split //, $code;
	return 0 if $s && $chars[0] =~ /[0-9]/;
	$_ = ord ($_) - 55 for grep { /[B-Z]/ } @chars;
	my $sum = 
		$chars[0] +
		$chars[1] * 3 +
		$chars[2] +
		$chars[3] * 7 +
		$chars[4] * 3 +
		$chars[5] * 9 +
		$chars[6];
	return $sum % 10 ? 0 : 1;
}
