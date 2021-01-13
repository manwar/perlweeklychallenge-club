#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
use List::MoreUtils qw(first_index);
use List::Util qw(reduce);
use Data::Dumper::OneLine;

# Magical Matrix
my @available = (1) x 10;
my @N = ([0, 0, 0], [0, 0, 0], [0, 0, 0]);

solve();

# Output
say Dumper($_) for(@N);

# Solve Magical Matrix
sub solve {
  my $row = -1;
  my $col = -1;

  for (my $i = 0; $i < 3; $i++) {
    my $index = first_index { $_ == 0 } @{$N[$i]};

    if ($index > -1) {
      $row = $i;
      $col = $index;
      last;
    }
  }

  return 1 if ($col == -1);

  my $result = 0;

  for(my $i = 1; $i < 10; $i++) {
    if (isSafe($row, $col, $i)) {
      $available[$i] = 0;
      $N[$row][$col] = $i;

      $result = solve();
      last if ($result);

      $available[$N[$row][$col]] = 1;
      $N[$row][$col] = 0;
    }
  }

  return $result;
}

# Test if element is safe
sub isSafe {
  my ($row, $col, $val) = @_;

  # Verify availability
  return 0 if(!$available[$val]);

  # Verify row
  return 0 if(!check15($N[$row][0], $N[$row][1], $N[$row][2], $val));

  # Verify column
  return 0 if(!check15($N[0][$col], $N[1][$col], $N[2][$col], $val));

  # Verify y=x diagonal
  return 0 if($row == $col && !check15($N[0][0], $N[1][1], $N[2][2], $val));

  # Verify y=-x diagonal
  return 0 if($row + $col == 2 && !check15($N[0][2], $N[1][1], $N[2][0], $val));

  return 1;
}

# Check if can have 15
sub check15 {
  my $zeros = scalar(grep { $_ == 0 } @_);
  my $sum = reduce { $a + $b } @_;

  return 0 if($zeros == 1 && $sum != 15);
  return 0 if($zeros == 2 && $sum <= 5);
  return 0 if($zeros == 2 && $available[15 - $sum] == 0);
  return 1;
}
