#!/usr/bin/perl

# Perl Weekly Challenge - 093
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-093/
#
# Task 2 - Sum Path
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::Util qw(sum);
use Data::Printer;

sub treeTotal(\@\@\%);

# Unbuffered STDOUT
$|++;

my %tree = ( 
  'Tree 1' => {
    1 => { 
      2 => { 
        3 => undef,
        4 => undef,
      }
    }
  },
  'Tree 2' => {
    1 => { 
      2 => { 
        4 => undef
      },
      3 => {
        5 => undef,
        6 => undef,
      }
    }
  },
  'Tree 3' => {
    3 => {
      9 => undef,
      3 => {
        2 => undef,
        1 => undef,
      },
    }
  },
);

foreach my $case (sort keys %tree) {
  my (@sum, @nodes);

  treeTotal(@sum, @nodes, %{$tree{$case}});

  my $sum = sum(map{sum @$_} @sum);

  printf "===============================\n";
  printf "Tree: '%s'\n", $case;
  printf "Sum: %d\n", $sum;
  printf "Paths: (%s)\n", join('),(', map {join(',', @$_)} @sum);
  printf "===============================\n\n";
}

sub treeTotal (\@\@\%) {
  my ($arT, $arN, $hr) = @_;
  my @n = @$arN;

  foreach my $k (keys %$hr) {
    if (scalar(keys %{$hr->{$k}})) {
      push(@n, $k);
      treeTotal(@$arT, @n, %{$hr->{$k}});
      pop(@n);
    } else {
      push(@$arT, [@n, $k]);
    }
  }
}
