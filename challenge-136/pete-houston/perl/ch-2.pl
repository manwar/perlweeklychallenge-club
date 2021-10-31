#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13602.pl
#
#        USAGE: ./13602.pl N
#
#  DESCRIPTION: How many distinct sums of unique Fibonacci numbers total N?
#
# REQUIREMENTS: Algorithm::Knapsack, Params::Util, List::Util
#        NOTES: Essentially the same as 7701.pl, just different output
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 31/10/21
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

my $combos = grep { sum (@fib[@$_]) == $tot } $sack->solutions;

# Output
print "$combos\n";
