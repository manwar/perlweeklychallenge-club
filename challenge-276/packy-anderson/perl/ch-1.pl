#!/usr/bin/env perl
use v5.40;

sub completeDays(@hours) {
  my @pairs;
  foreach my $i ( 0 .. $#hours - 1 ) {
    foreach my $j ( $i + 1 .. $#hours) {
      push @pairs, [ $hours[$i], $hours[$j] ]
        if ( $hours[$i] + $hours[$j] ) % 24 == 0;
    }
  }
  my $explain = "";
  foreach my $i ( 0 .. $#pairs ) {
    $explain .= "\n" . "Pair " . ($i+1) . ": ("
             . join(", ", @{ $pairs[$i] }) . ")"
  }
  return scalar(@pairs), $explain;
}

sub solution($hours) {
  say 'Input: @hours = (' . join(', ', @$hours) . ')';
  my ($count, $explain) = completeDays(@$hours);
  say "Output: $count\n$explain";
}

say "Example 1:";
solution([12, 12, 30, 24, 24]);

say "\nExample 2:";
solution([72, 48, 24, 5]);

say "\nExample 3:";
solution([12, 18, 24]);
