#! /usr/bin/perl

use strict;
use warnings;
use feature qw(say);

my $N = $ARGV[0] || 2;

#Short but ineffecient, fails N = 9
my @rares = grep{($_-reverse>-1)&&sqrt($_+reverse)!~/\./&&sqrt($_-reverse)!~/\./}10**~-$N..~-10**$N;
say "Rare with $N digits: @rares"

# =begin
# Rare with 1 digits: 2 8
# Rare with 2 digits: 65
# Rare with 3 digits: 242
# Rare with 4 digits: 
# Rare with 5 digits: 20402 24642
# Rare with 6 digits: 621770
# Rare with 7 digits: 2004002 2138312 2468642
# Rare with 8 digits: 85099058
# Rare with 9 digits: Killed!
# =cut


