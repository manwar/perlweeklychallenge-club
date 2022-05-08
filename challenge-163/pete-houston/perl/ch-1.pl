#!/usr/bin/env perl
#===============================================================================
#
#         FILE: 16301.pl
#
#        USAGE: ./16301.pl N N [ N ] ...
#
#  DESCRIPTION: Output the sum of the bitwise AND of each unique pair
#               from the positive intgers N
#
# REQUIREMENTS: List::Util 1.55, Math::Combinatorics
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 03/05/22
#===============================================================================

use strict;
use warnings;

use List::Util 1.55 'uniqint';
use Math::Combinatorics;

# Extract nCr with r = 2
my $combo = Math::Combinatorics->new (
	count => 2,
	data  => [uniqint @ARGV]
);

my $tot = 0;
while (my @c = $combo->next_combination) {
	$tot += $c[0] & $c[1];
}

print "$tot\n";
