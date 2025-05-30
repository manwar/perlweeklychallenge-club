#!/usr/bin/env perl
use v5.40;

sub incDec(@operations) {
  my ($x, $old_x, $o) = (0, 0, q{});
  my @explain;
  for my $op ( @operations ) {
    $x = ($op =~ /\+\+/) ? $x + 1 : $x - 1;
    $o = ($op =~ /\+\+/) ?   '+'  :   '-';
    push @explain,
      sprintf 'Operation "%s" => %2d %s 1 => %2d',
                         $op, $old_x, $o, $x
    ;
    $old_x = $x;
  }
  return ($x, join("\n", @explain));
}

sub solution($operations) {
  say 'Input: @operations = ("' . join('", "', @$operations) . '")';
  my ($output, $explain) = incDec(@$operations);
  say "Output: $output\n\n$explain";
}

say "Example 1:";
solution(["--x", "x++", "x++"]);

say "\nExample 2:";
solution(["x++", "++x", "x++"]);

say "\nExample 3:";
solution(["x++", "++x", "--x", "x--"]);
