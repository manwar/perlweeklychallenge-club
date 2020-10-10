#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8101.pl
#
#        USAGE: ./8101.pl string1 string2 
#
#  DESCRIPTION: Find complete common substrings
#
# REQUIREMENTS: Math::Prime::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 05/10/20
#===============================================================================

use strict;
use warnings;
use Math::Prime::Util 'gcd';

# Find longest possible substring
my @str     = @ARGV[0, 1];
my @len     = map { length } @str;
my $longest = gcd (@len);

# Count up
my $ans;
LENGTH:
for my $i (1 .. $longest) {
	my $substr = substr ($str[0], 0, $i);
	last unless substr ($str[1], 0, $i) eq $substr;
	for my $j (0, 1) {
		next LENGTH if $len[$j] % $i;
		next LENGTH if $str[$j] ne $substr x ($len[$j] / $i);
	}
	$ans = $substr;
}

$ans //= 'No common base string';
print "$ans\n";
