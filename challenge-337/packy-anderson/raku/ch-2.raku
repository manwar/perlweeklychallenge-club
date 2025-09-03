#!/usr/bin/env raku
use v6;

# take two displayMatrix() strings and display them side-by-side
sub displayTwo($display1, $display2) {
  # split the two strings and join each row together
  my @display = $display1.split(/\n/) Z~ $display2.split(/\n/);
  @display.join("\n")
}

sub displayMatrix($label, @matrix) {
  my $width = (@matrix[0].elems + 2) * 2 + 1;
  my $display = sprintf "%-*s\n", $width, $label;
  for 0 .. @matrix.end -> $r {
    my @row = @matrix[$r];
    $display ~= "[ " ~ @row.join(" ") ~ " ]  \n";
  }
  $display
}

sub emptyMatrix($row, $col) {
  my @matrix;
  for 1..$row -> $r { @matrix.push([ 0 xx $col ]); }
  @matrix;
}

sub incrementRow($row, @matrix is copy) {
  for 0..@matrix[0].end -> $col { @matrix[$row][$col]++; }
  @matrix
}

sub incrementCol($col, @matrix is copy) {
  for 0..@matrix.end -> $row { @matrix[$row][$col]++; }
  @matrix
}

sub countOdd(@matrix) {
  my $count = 0;
  for 0..@matrix.end -> $row {
    for 0..@matrix[0].end -> $col {
      $count++ if @matrix[$row][$col] % 2;
    }
  }
  $count
}

sub oddMatrix($row, $col, @locations) {
  my @matrix = emptyMatrix($row, $col);
  my $display = displayMatrix("Initial:", @matrix);
  for @locations -> ($row, $col) {
    $display ~= "\nApply [$row,$col]:\n";

    $display ~= "Increment row $row:\n";
    my $before = displayMatrix("Before", @matrix);
    @matrix = incrementRow($row, @matrix);
    my $after = displayMatrix("After", @matrix);
    $display ~= displayTwo($before, $after);

    $display ~= "Increment col $col:\n";
    $before = displayMatrix("Before", @matrix);
    @matrix = incrementCol($col, @matrix);
    $after = displayMatrix("After", @matrix);
    $display ~= displayTwo($before, $after);
  }
  $display ~= "\n";
  return
    countOdd(@matrix),
    $display ~ displayMatrix('Final:', @matrix);
}

sub solution($row, $col, @locations) {
  my $loc_list = @locations.map({ qq{[$_[0],$_[1]]} }).join(',');
  say qq{Input: \$row = $row, \$col = $col, }
    ~ qq{\@locations = ($loc_list)};
  my ($odd, $explain) = oddMatrix($row, $col, @locations);
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
