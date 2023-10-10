#!/usr/bin/env raku
use v6;

sub persistenceSort(*@int) {
  my %step_count;
  my $steps;
  # first, calculates the steps for each number
  for @int -> $num {
    %step_count{$num} = 0;

    $steps ~= "\n$num"; # our starting number

    my $num_copy = $num; # copy the num so we can modify it

    while ( $num_copy.Str.chars > 1 ) {
      # split $num_copy into its individual digits
      my @digits = $num_copy.split('', :skip-empty);

      # generate a new number by multiplying all the digits
      $num_copy = [*] @digits;

      # show the multiplication in the steps for this num
      $steps ~= ' => ' ~ @digits.join(' x ');
      $steps ~= " => $num_copy";

      # add to our count of steps
      %step_count{$num}++;
    }

    # put the step count in the steps for this num
    $steps ~=
      sprintf " (%d step%s)", %step_count{$num},
              %step_count{$num} == 1 ?? '' !! 's';
  }

  # now, sort by steps/numeric value
  my @sorted = @int.sort({
    # sort by step count
    %step_count{$^a} <=> %step_count{$^b}
    ||
    # then sort numerically
    $^a <=> $^b
  });

  return @sorted, $steps;
}

sub solution {
  my @int = @_;
  say 'Input: @int = (' ~ @int.join(', ') ~ ')';
  # if we attempt to capture the returned array in
  # @sorted, the array becomes the first ELEMENT in
  # @sorted (and the steps Str becomes the second
  # element) so we capture it in $sorted
  my ($sorted, $steps) = persistenceSort(@int);
  say 'Output: (' ~ $sorted.join(', ') ~ ')';
  say $steps;
}

say "Example 1:";
solution(15, 99, 1, 34);

say "\nExample 2:";
solution(50, 25, 33, 22);