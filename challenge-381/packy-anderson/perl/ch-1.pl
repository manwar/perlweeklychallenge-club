#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( zip_by );

sub hasAllNum($n, @elems) {
  my %set = map { $_ => 1 } @elems;
  return false unless (keys %set == $n); # check num of elems
  for my $i ( 1 .. $n ) {
    return false unless exists $set{$i};
  }
  return true;
}

sub sameRowColumn(@matrix) {
  my $n = @matrix;
  for my $r (0 .. $n-1) {
    # check the row
    return 'False' unless hasAllNum($n, @{$matrix[$r]});
  }
  my @col = zip_by { [ @_ ] } @matrix; # flip rows and col
  # check columns
  for my $c (0 .. $n-1) {
    return 'False' unless hasAllNum($n, @{$col[$c]});
  }
  return 'True';
}

sub formatMatrix($matrix, $indent=17) {
  my @output;
  foreach my $row (@$matrix) {
    my $output_row = q{ } x $indent . "  [";
    $output_row .= join(', ', map { sprintf "%1d", $_ } @$row) . ']';
    push @output, $output_row;
  }
  return "[\n"
       . join(",\n", @output)
       . "\n"
       . q{ } x $indent . "]";
}

sub solution($matrix) {
  say 'Input: @matrix = ' . formatMatrix($matrix);
  say 'Output: ' . sameRowColumn(@$matrix);
}

say "Example 1:";
solution([
  [1, 2, 3, 4],
  [2, 3, 4, 1],
  [3, 4, 1, 2],
  [4, 1, 2, 3]
]);

say "\nExample 2:";
solution([[1],]);

say "\nExample 3:";
solution([
  [1, 2, 5],
  [5, 1, 2],
  [2, 5, 1]
]);

say "\nExample 4:";
solution([
  [1, 2, 3],
  [1, 2, 3],
  [1, 2, 3] 
]);

say "\nExample 5:";
solution([
  [1, 2, 3],
  [3, 1, 2],
  [3, 2, 1]
]);

