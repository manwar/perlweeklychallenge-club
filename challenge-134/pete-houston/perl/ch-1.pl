#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13401.pl
#
#        USAGE: ./13401.pl [ N ] 
#
#  DESCRIPTION: Print first 5 (or N) pandigital decimal numbers
#
#      OPTIONS: If N is not provided, defaults to 5.
# REQUIREMENTS: Math::Combinatorics for permutations
#        NOTES: This will fail for sufficiently high N (>10^6 or so)
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 11/10/21
#===============================================================================

use strict;
use warnings;
use Math::Combinatorics;

# General case
my $n   = $ARGV[0] // 5;
my $i   = 1;
my $fac = 1;
$i++ while (($fac *= $i) < $n);

# Permute the $i highest digits
my $smallest = "1023456789";
my $post = substr $smallest, 10 - $i, $i, '';
my @swaps = split (//, $post);

my $combo = Math::Combinatorics->new (count => $i, data => [@swaps]);
my @pans;

while (my @perm = $combo->next_permutation) {
	push @pans, join '', $smallest, @perm;
}

# Sort these, print the first $n
for my $pan (sort @pans) {
	print "$pan\n";
	last unless --$n;
}
