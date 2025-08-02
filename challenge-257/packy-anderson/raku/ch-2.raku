#!/usr/bin/env raku
use v6;

sub rowIsEntirelyZeros(@row) {
  for @row -> $n {
    next if $n == 0;
    return 0;
  }
  return 1;
}

sub rowHasLeadingOne(@row) {
  for @row -> $n {
    next if $n == 0;
    return $n == 1;
  }
}

sub leadingOnePosition(@row) {
  for 0 .. @row.end -> $i {
    next if @row[$i] == 0;
    return $i;
  }
}

sub columnHasZerosBesidesLeadingOne(@matrix, $col) {
  my $count = 0;
  for @matrix -> @row {
    next if @row[$col] == 0; # skip zeroes
    return 0 if @row[$col] != 1; # fail if not one
    $count++; # count ones
  }
  return $count == 1;
}

sub isReducedRowEchelon(@matrix) {
  my $foundAllZeroRow = 0;
  my $lastLeadingOnePos = -1; # avoid comparison with undef
  for @matrix -> @row {
    if (! rowIsEntirelyZeros(@row)) {
      # 1. If a row does not consist entirely of zeros, then
      #    the first nonzero number in the row is a 1. We call
      #    this the leading 1.
      return 0 unless rowHasLeadingOne(@row);

      # 2. If there are any rows that consist entirely of zeros,
      #    then they are grouped together at the bottom of the
      #    matrix.
      return 0 if $foundAllZeroRow;

      # 3. In any two successive rows that do not consist
      #    entirely of zeros, the leading 1 in the lower row
      #    occurs farther to the right than the leading 1 in
      #    the higher row.
      my $thisLeadingOnePos = leadingOnePosition(@row);
      return 0 if $lastLeadingOnePos > $thisLeadingOnePos;
      $lastLeadingOnePos = $thisLeadingOnePos;

      # 4. Each column that contains a leading 1 has zeros
      #    everywhere else in that column.
      return 0 unless columnHasZerosBesidesLeadingOne(
        @matrix, $thisLeadingOnePos
      );
    }
    else {
      $foundAllZeroRow = 1;
    }
  }
  return 1;
}

sub formatMatrix(@matrix, $indent=12) {
  my @output;
  for @matrix -> @row {
    my $output_row = q{ } x $indent ~ "  [ ";
    $output_row ~= @row.map({ sprintf "%2d", $_ })
                       .join(', ') ~ "]";
    @output.push($output_row);
  }
  return "[\n"
       ~ @output.join(",\n")
       ~ "\n"
       ~ q{ } x $indent ~ "]";
}

sub solution(@matrix) {
  say 'Input: $M = ' ~ formatMatrix(@matrix);
  my $output = isReducedRowEchelon(@matrix);
  say 'Output: ' ~ $output;
}

say "Example 1:";
solution([
  [1, 1, 0],
  [0, 1, 0],
  [0, 0, 0]
]);

say "\nExample 2:";
solution([
  [0, 1,-2, 0, 1],
  [0, 0, 0, 1, 3],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0]
]);

say "\nExample 3:";
solution([
  [1, 0, 0, 4],
  [0, 1, 0, 7],
  [0, 0, 1,-1]
]);

say "\nExample 4:";
solution([
  [0, 1,-2, 0, 1],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 1, 3],
  [0, 0, 0, 0, 0]
]);

say "\nExample 5:";
solution([
  [0, 1, 0],
  [1, 0, 0],
  [0, 0, 0]
]);

say "\nExample 6:";
solution([
  [4, 0, 0, 0],
  [0, 1, 0, 7],
  [0, 0, 1,-1]
]);

say "\nExample 7:";
solution([
  [1, 0, -1],
  [0, 1, 1],
  [0, 0, 1]
]);
