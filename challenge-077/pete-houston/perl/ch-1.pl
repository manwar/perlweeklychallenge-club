#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7701.pl
#
#        USAGE: ./7701.pl N 
#
#  DESCRIPTION: Outputs all sums of unique Fibonacci numbers to make N
#
# REQUIREMENTS: Algorithm::Knapsack, Params::Util, List::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 07/09/20
#===============================================================================

use strict;
use warnings;
use Algorithm::Knapsack;
use Params::Util '_POSINT';
use List::Util 'sum';

# Validate input
my $tot = shift;
die "Argument must be a whole number.\n" unless _POSINT $tot;

# Construct a big enough Fibonacci sequence. No duplicates!
my @fib = (1, 2);
push @fib, $fib[-1] + $fib[-2] while $fib[-1] + $fib[-2] <= $tot;

# Process
my $sack = Algorithm::Knapsack->new (
	capacity => $tot,
	weights  => \@fib,
);
$sack->compute;

# Output
my $combos = 0;
for my $fit ($sack->solutions) {
	next unless sum (@fib[@$fit]) == $tot;
	print join (' + ', @fib[@$fit]) . " = $tot\n";
	$combos++;
}
print "0\n" unless $combos;
