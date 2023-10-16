#!/usr/bin/env perl
use v5.38;

use List::Util qw( product );

sub persistenceSort {
  my @int = @_;
  my %step_count;
  my $steps;
  # first, calculates the steps for each number
  foreach my $num ( @int ) {
    $step_count{$num} = 0;

    $steps .= "\n$num"; # our starting number

    my $num_copy = $num; # copy the num so we can modify it

    while ( length($num_copy) > 1 ) {
      # split $num_copy into its individual digits
      my @digits = split //, $num_copy;

      # generate a new number by multiplying all the digits
      $num_copy = product @digits;

      # show the multiplication in the steps for this num
      $steps .= ' => ' . join(' x ', @digits);
      $steps .= " => $num_copy";

      # add to our count of steps
      $step_count{$num}++;
    }

    # put the step count in the steps for this num
    $steps .=
      sprintf " (%d step%s)", $step_count{$num},
              $step_count{$num} == 1 ? '' : 's';
  }

  # now, sort by steps/numeric value
  my @sorted = sort {
    # sort by step count
    $step_count{$a} <=> $step_count{$b}
    ||
    # then sort numerically
    $a <=> $b
  } @int;

  return \@sorted, $steps;
}

sub solution {
  my @int = @_;
  say 'Input: @int = (' . join(', ', @int) . ')';
  my($sorted, $steps) = persistenceSort(@int);
  say 'Output: (' . join(', ', @$sorted) . ')';
  say $steps;
}

say "Example 1:";
solution(15, 99, 1, 34);

say "\nExample 2:";
solution(50, 25, 33, 22);