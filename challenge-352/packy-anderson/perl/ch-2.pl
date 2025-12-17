#!/usr/bin/env perl
use v5.40;

sub binaryPrefix(@nums) {
  my $bitwidth = @nums;
  my $bits     = q{};
  my $num      = 0;
  my $explain  = q{};
  my @output;
  foreach my $bit ( @nums ) {
    $num      = ($num * 2) + $bit;
    $bits    .= $bit;
    $explain .= sprintf("\n%*s: %d", $bitwidth, $bits, $num);
    push @output, ($num % 5 == 0 ? 'true' : 'false');
  }
  return $explain, join(", ", @output);
}

sub solution($nums) {
  say 'Input: @nums = (' . join(', ', @$nums) . ')';
  my ($explain, $output) = binaryPrefix(@$nums);
  say 'Output: (' . $output . ')';
  say "\nBinary numbers formed (decimal values):$explain";
}

say "Example 1:";
solution([0,1,1,0,0,1,0,1,1,1]);

say "\nExample 2:";
solution([1,0,1,0,1,0]);

say "\nExample 3:";
solution([0,0,1,0,1]);

say "\nExample 4:";
solution([1,1,1,1,1]);

say "\nExample 5:";
solution([1,0,1,1,0,1,0,0,1,1]);

