#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( pairwise );

# take two displayMatrix() strings and display them side-by-side
sub displayTwo($display1, $display2) {
  # split the two strings and join each row together
  my @d1 = split /\n/, $display1;
  my @d2 = split /\n/, $display2;
  join("\n", pairwise { $a . $b } @d1, @d2) . "\n";
}

sub displayMatrix($label, @matrix) {
  my $width = (scalar(@{$matrix[0]}) + 2) * 2 + 1;
  my $display = sprintf "%-*s\n", $width, $label;
  foreach my $r (0 .. $#matrix) {
    my $row = $matrix[$r];
    $display .= "[ " . join(" ", @$row) . " ]  \n";
  }
  $display
}

sub emptyMatrix($row, $col) {
  my @matrix;
  foreach my $r (1 .. $row) { push @matrix, [ (0) x $col ]; }
  @matrix;
}

sub incrementRow($row, @matrix) {
  foreach my $col ( 0 .. $#{$matrix[0]} ) {
    $matrix[$row][$col]++;
  }
  @matrix
}

sub incrementCol($col, @matrix) {
  foreach my $row ( 0 .. $#matrix ) { $matrix[$row][$col]++; }
  @matrix
}

sub countOdd(@matrix) {
  my $count = 0;
  foreach my $row ( 0 .. $#matrix ) {
    foreach my $col ( 0 .. $#{$matrix[0]} ) {
      $count++ if $matrix[$row][$col] % 2;
    }
  }
  $count
}

sub oddMatrix($row, $col, @locations) {
  my @matrix = emptyMatrix($row, $col);
  my $display = displayMatrix("Initial:", @matrix);
  foreach my $location ( @locations ) {
    my ($row, $col) = @$location;
    $display .= "\nApply [$row,$col]:\n";

    $display .= "Increment row $row:\n";
    my $before = displayMatrix("Before", @matrix);
    @matrix = incrementRow($row, @matrix);
    my $after = displayMatrix("After", @matrix);
    $display .= displayTwo($before, $after);

    $display .= "Increment col $col:\n";
    $before = displayMatrix("Before", @matrix);
    @matrix = incrementCol($col, @matrix);
    $after = displayMatrix("After", @matrix);
    $display .= displayTwo($before, $after);
  }
  $display .= "\n";
  return
    countOdd(@matrix),
    $display . displayMatrix('Final:', @matrix);
}

sub solution($row, $col, $locations) {
  my $loc_list = join ",", map { qq{[$_->[0],$_->[1]]} } @$locations;
  say qq{Input: \$row = $row, \$col = $col, }
    . qq{\@locations = ($loc_list)};
  my ($odd, $explain) = oddMatrix($row, $col, @$locations);
  say "Output: $odd";
  say "\n$explain";
}

say "Example 1:";
solution(2, 3, [[0,1],[1,1]]);

say "\nExample 2:";
solution(2, 2, [[1,1],[0,0]]);

say "\nExample 3:";
solution(3, 3, [[0,0],[1,2],[2,1]]);

say "\nExample 4:";
solution(1, 5, [[0,2],[0,4]]);

say "\nExample 5:";
solution(4, 2, [[1,0],[3,1],[2,0],[0,1]]);
