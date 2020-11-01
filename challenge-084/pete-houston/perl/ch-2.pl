#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8402.pl
#
#        USAGE: ./8402.pl  
#
#  DESCRIPTION: Find squares with all-1 corners in 2-d bit array
#
# REQUIREMENTS: List::Util
#        NOTES: Array is read from STDIN
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 31/10/20
#===============================================================================

use strict;
use warnings;
use List::Util 'min';

my @a; # Bit array
my $count = 0;

# Input
print "Enter your array, 1 row at a time.\n";
while (<STDIN>) {
	push @a, [/[01]/g];
}

# Make sure it is rectangular
validate (\@a);

# Find the squares
my $min = min ($#a, $#{$a[0]}); 
for my $y (0 .. $#a - 1) {
	for my $x (0 .. $#{$a[0]} - 1) {
		next unless $a[$y][$x];
		for my $offset (1 .. min ($#a - $y, $#{$a[0]} - $x)) {
			$count++ if $a[$y + $offset][$x] &&
				$a[$y][$x + $offset] &&
				$a[$y + $offset][$x + $offset];
		}
	}
}

# Output
print "$count\n";

sub validate {
	my $arr = shift;
	my $len = $#{$arr->[0]};
	for (1 .. $#$arr) {
		die "Rows have different lengths" unless $#{$arr->[$_]} == $len;
	}
}
