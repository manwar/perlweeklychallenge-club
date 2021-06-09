#!/usr/bin/perl

# Perl Weekly Challenge - 116
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-116/#TASK1
#
# Task 1 - Number Sequence
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use POSIX qw(ceil);

use Test::More;

my %tests = (
   '1234' => 1,
   '91011' => 1,
   '102030' => 0,
   '102103104' => 1,
   '123456123458' => 0,
   '8910111213141589101112131416' => 1,
);

foreach my $test (sort keys %tests) {
  printf "$test\n" unless is(isNumberSequence($test),$tests{$test});
}

done_testing();

sub isNumberSequence {
  my ($n) = @_;

  my $len = 1;

  do {
    my ($startNumber,$l) = (substr($n,0,$len),$len);
    my ($next,$s) = ($startNumber+1);
    while ($s = substr($n,$l) and $s =~ m#^$next#) {
      return 1 if ($' eq '');
      $l += length($next++);
    } 
    $len++;
  } while ($len <= ceil(length($n)/2));
  
  return 0;
}
