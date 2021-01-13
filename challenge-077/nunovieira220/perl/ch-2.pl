#!/usr/bin/perl

use strict;
use warnings;

# Input/Output
my @arr = (
  ['0', '0', 'X', '0'],
  ['X', '0', '0', '0'],
  ['X', '0', '0', 'X'],
  ['0', 'X', '0', '0']
);

# Count lonely X
my $X = scalar(@arr);
my $Y = scalar(@{$arr[0]});
my $counter = 0;

for(my $i = 0; $i < $X; $i++) {
  for(my $j = 0; $j < $Y; $j++) {
    $counter++ if($arr[$i][$j] eq 'X' && is_lonely($i, $j));
  }
}

print $counter."\n";

# Test if lonely
sub is_lonely {
  my ($i, $j) = @_;

  return is_blank($i-1, $j-1)
    && is_blank($i-1, $j)
    && is_blank($i-1, $j+1)
    && is_blank($i, $j-1)
    && is_blank($i, $j+1)
    && is_blank($i+1, $j-1)
    && is_blank($i+1, $j)
    && is_blank($i+1, $j+1);
}

# Test if element is blank
sub is_blank {
  my ($i, $j) = @_;
  return $i < 0 || $i == $X || $j < 0 || $j == $Y || $arr[$i][$j] eq '0';
}