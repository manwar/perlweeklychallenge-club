#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8002.pl
#
#        USAGE: ./8002.pl N ...
#
#  DESCRIPTION: Candy counting
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 28/09/20 15:44:45
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

# Logic:
# if we have n canditates, that's a minimum of n candies.
my $tot = scalar @ARGV;

# Then we have n-1 pairs. If each pair has the same ranking, there is no
# addition. If each pair has a different ranking, there is one extra
# candy awarded.
for my $i (1 .. $#ARGV) {
	$tot++ unless $ARGV[$i] == $ARGV[$i-1];
}

print "$tot\n";
