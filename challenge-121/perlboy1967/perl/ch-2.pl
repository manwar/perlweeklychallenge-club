#!/usr/bin/perl

# Perl Weekly Challenge - 121
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-121/#TASK1
#
# Task 2 - The Travelling Salesman
#
# Author: Niels 'PerlBoy' van Dijke
#

use v5.16;
use strict;
use warnings;

# Prototype(s)
sub theTravellingSalesman($);
sub genMatrix($);
sub printMatrix($);

use Data::Printer output => 'stdout';

use MCE;
use MCE::Util;

use List::Util qw(sum min);
use List::MoreUtils qw(slide);
use Algorithm::Combinatorics qw(permutations);

use Test::More;
use Test::Deep qw(cmp_deeply);

# Generate some random matrixes and solve the 'shortest path problem'
# (brute force method, using 'permutations')
foreach my $n (3 .. 12) {
  printf "Size: %d\n", $n;

  my $tM = genMatrix($n);
  printMatrix($tM);

  my $res = theTravellingSalesman($tM);

  printf "Tour: %s\n", join(',',@{$res->[1]});
  my $i = 1;
  printf "   sum(%s) = %d\n", join(',',slide { $tM->[$a][$b] } @{$res->[1]}), $res->[0];

  printf "--------------------------------\n";
}


sub theTravellingSalesman($) {
  my ($arM) = @_;

  my $min;
  my $minP;

  # Suppress 'Name "main::(a|b)" used only once: possible typo' messages
  ($a,$b) = (0,0);

  my %res;

  # Using brute force 'permutations'
  my @i = (0 ..  scalar(@{$arM->[0]})-1);
  my $iter = permutations(\@i);

  my $mce = MCE->new(
    chunk_size => 1_000,
    max_workers => MCE::Util::get_ncpu(),
    gather => \%res,
    user_func => sub {
      my ($mce, $chunk_ref, $chunk_id) = @_;

      my %ret; my $min; my @minV;
      foreach (@$chunk_ref) {

        # This is the 'magic' line ;-)
        my $m = sum slide {$arM->[$a][$b]} @$_, $_->[0];

        if (!defined $min or $m < $min) {
          @minV = (@$_, $_->[0]);
          $min = $m
        }
      }
      $ret{$min} = [@minV]; 
      MCE->gather(%ret);
    }
  );

  my @p;
  while (my $ar = $iter->next) {
    push(@p,$ar);
    if (scalar(@p) == 10_000) {
      print STDERR '.';
      $mce->process([@p]);
      @p = ();
    }
  }
  print STDERR "\n";

  $mce->process([@p]) if (scalar(@p)); 

  $min = min(keys %res);

  return [$min,$res{$min}];
}


sub genMatrix($) {
  my ($n) = @_;

  return [ map { $a = $_; [ map { $_ == $a ? 0 : int(1+rand(9)) } 0 .. $n -1 ] } 0 .. $n - 1];
}


sub printMatrix($) {
  my ($arM) = @_;

  print "Matrix:";
  foreach my $r (@$arM) {
    printf "\t".('%d ' x @{$arM->[0]})."\n", @$r;
  }
}
