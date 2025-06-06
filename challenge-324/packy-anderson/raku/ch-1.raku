#!/usr/bin/env raku
use v6;

sub twoDarray(@ints, $r, $c) {
  if (@ints.elems != $r * $c) {
    return ["Unable to create a two-dimensional array with "
         ~ "$r rows and $c columns\nfrom a list of {@ints.elems} "
         ~ "integers; there must be {$r * $c} integers."];
  }
  my @arr;
  while (@ints) {
    my @row;
    @row.push( @ints.shift ) for 1 .. $c ;
    @arr.push(@row);
  }
  return @arr;
}

sub formatMatrix(@matrix, $indent=8) {
  my @output;
  for @matrix -> @row {
    my $output_row = q{ } x $indent ~ "  [";
    $output_row ~= @row.map({ sprintf "%1d", $_ })
                       .join(', ') ~ "]";
    @output.push($output_row);
  }
  return "[\n"
       ~ @output.join(",\n")
       ~ "\n"
       ~ q{ } x $indent ~ "]";
}

sub solution(@ints, $r, $c) {
  my $ints = '(' ~ @ints.join(', ') ~ ')';
  say "Input: \@ints = $ints, \$r = $r, \$c = $c";
  my @arr = twoDarray(@ints, $r, $c);
  if (@arr[0].isa("Str") ) {
    say "";
    say @arr[0];
  }
  else {
    say "Output: {formatMatrix(@arr)}";
  }
}

say "Example 1:";
solution([1, 2, 3, 4], 2, 2);

say "\nExample 2:";
solution([1, 2, 3], 1, 3);

say "\nExample 3:";
solution([1, 2, 3, 4], 4, 1);

say "\nExample 4:";
solution([1, 2, 3, 4], 3, 1);

say "\nExample 4:";
solution([1, 2, 3, 4], 3, 2);
