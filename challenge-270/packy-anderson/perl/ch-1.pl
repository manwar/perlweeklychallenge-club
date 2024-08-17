#!/usr/bin/env perl
use v5.38;

use List::Util qw( sum );
use Lingua::EN::Inflexion qw( wordlist );

sub sumRow($matrix, $i) {
  return sum @{ $matrix->[$i] };
}

sub sumCol($matrix, $j) {
  return sum map { $_->[$j] } @$matrix;
}

sub specialPositions(@matrix) {
  my @special;
  foreach my $i ( 0 .. $#matrix ) {
    my @row = @{$matrix[$i]};
    foreach my $j ( 0 .. $#row ) {
      my $value = $row[$j];
      # not special unless = 1
      next unless $value == 1;
      # not special unless only 1 in row
      next unless sumRow(\@matrix, $i) == 1;
      # not special unless only 1 in column
      next unless sumCol(\@matrix, $j) == 1;
      # it's special!
      push @special, "($i, $j)";
    }
  }
  my $list = wordlist(@special, { sep => ',' });
  my $explain = 'Special position';
  $explain .= (@special == 1) ? ' is ' : 's are ';
  $explain .= $list;
  return scalar(@special), $explain;
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
  say 'Input: $matrix = ' . formatMatrix($matrix);
  my ($count, $explain) = specialPositions(@$matrix);
  say "Output: $count\n\n$explain";
}

say "Example 1:";
solution([
  [1,0,0],
  [0,0,1],
  [1,0,0]
]);

say "\nExample 2:";
solution([
  [1,0,0],
  [0,1,0],
  [0,0,1]
]);
