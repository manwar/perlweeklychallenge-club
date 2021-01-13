#!/usr/bin/perl

# Perl Weekly Challenge - 075
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-075/
#
# Task 2 - Largest Rectangle Histogram
#
# Author: Niels 'PerlBoy' van Dijke

# Try:
#  1) Without command line arguments
#  2) With arguments: 1 2 3 4

use strict;
use warnings;

use List::Util qw(max);
use List::MoreUtils qw(uniq);

sub getLRH(\@); 
sub printHistogram (\@$$\@);


my @A = @ARGV;

@A = qw(1 3 6 2 6 6 12 3 4)
  unless scalar @A;


my ($surface, $surfaceHeight, @indexes) = getLRH(@A);

printHistogram(@A, $surface, $surfaceHeight, @indexes);


sub getLRH (\@) {
  my ($arA) = @_;

  my %areas;
  my %surfaces;

  # Find indexes in list of items with values of same minimum
  foreach my $value (sort(uniq(@$arA))) {
    my $i = 0;
    foreach (@$arA) {
      if ($arA->[$i] >= $value) { 
        if (!defined $areas{$value}[-1] or 
            $areas{$value}[-1][-1] != $i - 1) {
         push(@{$areas{$value}}, [$i]);
        } else {
         push(@{$areas{$value}[-1]}, $i);
        }
      }
      $i++;
    }
  }

  # Calculate surfaces
  foreach my $v (sort keys %areas) {
    foreach my $i (@{$areas{$v}}) { 
      my $surface = $v * scalar(@$i);
      push(@{$surfaces{$surface}}, $i);
    }
  }

  my $maxSurface = max(keys %surfaces);
  my $indexCount = scalar(@{$surfaces{$maxSurface}});
  if ($indexCount == 1) {
    return ($maxSurface, 
            $maxSurface / scalar @{$surfaces{$maxSurface}[0]},
            @{$surfaces{$maxSurface}[0]});
  } else {
    printf "\n%d rectangles found with surface = %s\n",
          $indexCount, $maxSurface;
    foreach my $i (0 .. $indexCount - 1 ) {
      printf "\t%2d) [%s]\n", 
             $i + 1, 
             join(', ', map { $arA->[$_] } @{$surfaces{$maxSurface}[$i]});
    }

    print "\nNo surface highlighting will be given.\n\n";
    return ($maxSurface);
  }
}


sub printHistogram (\@$$\@) {
  my ($arA, $surface, $surfaceHeight, $arIndexes) = @_;

  if (defined $surfaceHeight) {
    printf "\nSurface size: %d (%d x %d)\n\n", 
           $surface, 
           scalar @$arIndexes, $surfaceHeight;
  }

  my $max = max(@$arA);
  my $yLw = length($max);

  my %indexes = map { $_ => 1 } @$arIndexes;

  # Print historgram rows
  for (my $row = $max; $row > 0; $row--) {
    my @row = (sprintf("%${yLw}s", $row), '|');
    for my $col (0 .. scalar(@$arA) - 1) {
      if ($arA->[$col] < $row) {
        push(@row, ' ');
      } else {
        push(@row, (!exists $indexes{$col} || 
                    $row > $surfaceHeight ? '#' : 'O'));
      }
    }
    print join(" ", @row)."\n";
  }

  # Print X-axis
  print sprintf("%${yLw}s +%s\n", 
                '', 
                join('-', map { '-' } @$arA, ''));

  # Print X labels
  for my $l (0 .. $yLw - 1) {
    print sprintf("%${yLw}s   %s\n",
                  '', 
                  join(' ', map { substr($_.' ' x $yLw, $l, 1) } @$arA));
  }
}
               


