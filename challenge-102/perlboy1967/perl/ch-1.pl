#!/usr/bin/perl

# Perl Weekly Challenge - 102
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-102/#TASK1
#
# Task 1 - Rare Numbers
#
# Author: Niels 'PerlBoy' van Dijke
#
# Note: This is the first time I use MCE.
# Possibly I use it not optimally ;-)

use v5.16;
use strict;
use warnings;

use MCE;
use MCE::Util;

use POSIX qw(ceil);
use Time::HiRes qw(gettimeofday tv_interval);
use List::Util qw(min);

@ARGV = (9)
  unless (scalar @ARGV);

my $N = shift @ARGV;

die "Please provide integer number >= 1"
  unless ($N =~ m#^\d+$# and $N >= 1);

my %rep = (
  1 => 2,
  3 => 4,
  5 => 6,
  7 => 8,
  9 => 20,
);

my ($r0,$r1) = (1,1);

my $t0 = [gettimeofday];

my @results;

my $mce = MCE->new(
     chunk_size => 10_000,
     max_workers => MCE::Util::get_ncpu(),
     user_func => sub {
       my ($mce, $chunk_ref, $chunk_id) = @_;

       foreach (@$chunk_ref) {
         if (isRare($_)) {
           my $elapsed = tv_interval ($t0);
           printf "%6.3f rare: %d\n", $elapsed, $_;
         }
       }
     }
);

do {
  $r0++;

  # Small optimization
  # (skip all numbers which start with an odd number)
  my $d = substr($r0,0,1);
  if (exists $rep{$d}) {
    substr($r0,0,1,$rep{$d});
  }

  # Create dynamic chunks with a maximum of 1M
  # (to keep memory utilisation in control)
  my $step = min(1_000_000, 10**ceil(log($r0)/log(10)) - 1 - $r0);
  $mce->process([ $r0 .. $r0+$step ]);
  $r0 += $step;

} until ($r0 > 10**$N);


sub isRare {
  my $r1 = int(reverse($_[0]));

  # Palindrome number cannot be rare number
  return 0 if ($r1 == $_[0]);

  my $d = $_[0] - $r1;
  return 0 if ($d <= 0);
  my $sqrtD = sqrt($d);
  return 0 if ($sqrtD != int($sqrtD));

  my $s = $_[0] + $r1;
  my $sqrtS = sqrt($s);
  return 0 if ($sqrtS != int($sqrtS));

  return 1;
}

