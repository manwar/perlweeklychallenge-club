#!/usr/bin/env perl

use v5.38;

sub findTriplets {
  my @ints = @_;
  my @solutions;
  foreach my $i ( 0 .. $#ints - 2 ) {
    foreach my $j ( $i+1 .. $#ints - 1 ) {
      foreach my $k ( $j+1 .. $#ints ) {
        if ($ints[$i] != $ints[$j] &&
            $ints[$j] != $ints[$k] &&
            $ints[$i] != $ints[$k]) {
          push @solutions, [$i, $j, $k];
        }
      }
    }
  }
  return @solutions;
}

sub solution {
  my @ints = @_;
  say 'Input: @ints = (' . join(', ', @ints) . ')';
  my @solutions = findTriplets(@ints);
  say 'Output: ' . scalar(@solutions);
  say "" if @solutions;
  foreach my $triplet ( @solutions ) {
    my($i, $j, $k) = @$triplet;
    say "($i, $j, $k) because "
      . "$ints[$i] != $ints[$j] != $ints[$k]";
  }
}

say "Example 1:";
solution(4, 4, 2, 4, 3);

say "\nExample 2:";
solution(1, 1, 1, 1, 1);

say "\nExample 3:";
solution(4, 7, 1, 10, 7, 4, 1, 1);