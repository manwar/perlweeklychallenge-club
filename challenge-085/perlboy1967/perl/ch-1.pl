#!/usr/bin/perl

# Perl Weekly Challenge - 085
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-085/
#
# Task 1 - Triplet Sum
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

# Unbuffered STDOUT
$|++;

# Prototype
sub between ($$$);

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);
use Scalar::Util qw(looks_like_number);

@ARGV = (1.2, 0.4, 0.1, 2.5)
  unless scalar(@ARGV);

die "Please provide minimally three real positive numbers"
  unless (scalar @ARGV > 2 and
          scalar grep {looks_like_number($_) and $_ > 0} @ARGV == scalar @ARGV);

my $tripletsFound = 0;
my $iter = combinations(\@ARGV, 3);
while (my $ar = $iter->next) {
  if (between(sum(@$ar),1,2)) {
    printf "Triplet (%s) 'fits' (1.0 < %s < 2.0)\n", 
      join(', ',@$ar), sum(@$ar);
    $tripletsFound++;
  }
}
print "No triplets found!\n" unless ($tripletsFound);

sub between ($$$) {
  return $_[0] > $_[1] && $_[0] < $_[2];
}
