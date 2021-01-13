#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper::OneLine;

# Input
my @N = (
  [ 1,  2,  3,  4],
  [ 5,  6,  7,  8],
  [ 9, 10, 11, 12],
  [13, 14, 15, 16]
);

# Spiral Matrix
my @result = handleMatrix(@N);

# Output
print Dumper(\@result);

# Handle matrix
sub handleMatrix {
  my @matrix = @_;
  my @res = ();

  return @res if(scalar @matrix == 0);

  my $firstRow = splice(@matrix, 0, 1);
  push @res, @{$firstRow};

  if(scalar @matrix > 0) {
    for(my $i = 0; $i < scalar @matrix - 1; $i++) {
      my $lastElem = splice(@{$matrix[$i]}, scalar(@{$matrix[$i]}) - 1, 1);
      push @res, $lastElem;
    }

    my $lastRow = splice(@matrix, scalar(@matrix) - 1, 1);
    push @res, reverse @{$lastRow};

    for(my $i = scalar @matrix - 1; $i >= 0; $i--) {
      my $firstElem = splice(@{$matrix[$i]}, 0, 1);
      push @res, $firstElem;
    }
  }

  push @res, handleMatrix(@matrix);

  return @res;
}