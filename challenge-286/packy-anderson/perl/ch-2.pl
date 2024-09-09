#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( min max );

sub orderGame(@ints) {
  my $loop = 0;
  my @explain;
  while (@ints > 1) {
    my @new;
    $loop++;
    push @explain, "Operation $loop:";
    push @explain, "";
    my $flip = 1;
    foreach my($a, $b) ( @ints ) {
      my ($val, $func);
      if ($flip == 1) {
        $val = min($a, $b);
        $func = 'min';
      }
      else { # $flip is -1
        $val = max($a, $b);
        $func = 'max';
      }
      push @new, $val;
      push @explain, "    $func($a, $b) = $val";
      $flip *= -1; # switch from min to max and back
    }
    push @explain, "";
    @ints = @new; # replace list with new list
  }
  return $ints[0], join("\n", @explain);
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  my ($output, $explain) = orderGame(@$ints);
  say 'Output: ' . $output;
  say "\n$explain";
}

say "Example 1:";
solution([2, 1, 4, 5, 6, 3, 0, 2]);

say "\nExample 2:";
solution([0, 5, 3, 2]);

say "\nExample 3:";
solution([9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]);
