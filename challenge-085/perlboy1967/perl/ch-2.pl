#!/usr/bin/perl

# Perl Weekly Challenge - 085
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-085/
#
# Task 2 - Power of Two integers
# You are given a positive integer $N.
#
# Write a script to find if it can be expressed as a ^ b where a > 0 and b > 1. Print 1 if you succeed otherwise 0.
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use Data::Printer;

# Unbuffered STDOUT
$|++;

# Prototype(s)
sub logN ($$);

my ($N) = @ARGV;

die "Please provide a positive integer"
  unless (defined $N and $N =~ m#^[1-9][0-9]*$#);

my @combinations;

if ($N > 1) {
  foreach my $b (2 .. int(logN($N,2))) {
    for my $p (2 .. int(logN($N,$b))) {
      push(@combinations,[$b,$p]) if ($b ** $p == $N);
    }
  }
}

print "Input: $N\n";
if ($N == 1) {
  printf "Output: 1 as 1 ^ x = 1 (where x > 1)\n";
} else {
  if (scalar @combinations) {
    print "Output: 1 as\n";
    printf "%s\n", join('', map { sprintf("\t%d = %d ^ %d\n", 
                                          $N, $_->[0], $_->[1]) 
                                } @combinations);
  } else {
    print "Output: 0\n";
  }
}


sub logN ($$) {
  return log(shift)/log(shift);
}
__END__
my $res = log($N)/log(2);
printf "$N %s %d\n", $res, ($res == int($res) ? 1 : 0)
