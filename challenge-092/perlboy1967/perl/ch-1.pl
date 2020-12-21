#!/usr/bin/perl

# Perl Weekly Challenge - 092
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-092/
#
# Task 1 - Isomorphic Strings
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Data::Printer;

# Unbuffered STDOUT
$|++;

@ARGV = ('abc','zyx')
  unless @ARGV;

my ($A,$B) = @ARGV;

die "Please provide two strings equal length strings"
  unless (defined $A and defined $B and length($A) == length($B));

printf "Input: ('%s','%s')\n", $A, $B;
printf "Output: %d\n", isIsomorphicString($A,$B);

sub isIsomorphicString {
  my ($a,$b) = @_;

  my @a = split(//, $a);
  my @b = split(//, $b);

  my %m;
  my $r = 1;
  foreach my $a (@a) {
    my $c = shift(@b);
    $m{$a} //= $c;
    if ($m{$a} ne $c) {
      $r = 0; last;
    }
  }

  return $r;
}

