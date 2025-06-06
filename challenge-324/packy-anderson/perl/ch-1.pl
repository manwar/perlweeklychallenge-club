#!/usr/bin/env perl
use v5.40;

sub twoDarray($ints, $r, $c) {
  if (scalar(@$ints) != $r * $c) {
    return "Unable to create a two-dimensional array with "
         . "$r rows and $c columns\nfrom a list of "
         . "@{[scalar @$ints]} integers; there must be "
         . "@{[$r * $c]} integers.";
  }
  my @arr;
  while (@$ints) {
    my @row;
    push @row, shift @$ints for 1 .. $c ;
    push @arr, \@row;
  }
  return undef, \@arr;
}

sub formatMatrix($matrix, $indent=8) {
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

sub solution($ints, $r, $c) {
  my $int_list = '(' . join(', ', @$ints) . ')';
  say "Input: \@ints = $int_list, \$r = $r, \$c = $c";
  my ($err, $arr) = twoDarray($ints, $r, $c);
  if ($err) {
    say "";
    say $err;
  }
  else {
    say "Output: @{[ formatMatrix($arr) ]}";
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
