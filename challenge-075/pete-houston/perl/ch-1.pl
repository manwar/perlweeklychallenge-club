#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7501.pl
#
#        USAGE: ./7501.pl TARGET COIN [ ... ] 
#
#  DESCRIPTION: Report how many ways to make a total from a coin set
#
# REQUIREMENTS: Algorithm::Knapsack, Lingua::EN::Inflexion
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 24/08/20
#===============================================================================

use strict;
use warnings;
use Algorithm::Knapsack;
use Lingua::EN::Inflexion;

# Construct a big enough set of coins
my $target = shift;
my @coins  = map {($_) x ($target / $_)} @ARGV;

# Process
my $sack = Algorithm::Knapsack->new (
	capacity => $target,
	weights  => \@coins,
);
$sack->compute;

# De-duplicate
my %sets;
$sets {join (',', @coins[@$_]) . "\n"} = 1 for $sack->solutions;

# Output
my $ways = keys %sets;
print inflect ("There <#d:$ways><V:is> <#nw:$ways> " .
	"<N:way> of paying $target:\n\n"),
	sort keys %sets;
