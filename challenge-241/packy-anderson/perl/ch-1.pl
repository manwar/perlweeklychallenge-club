#!/usr/bin/env perl
use v5.38;

sub findTriplets {
  my($diff, $nums) = @_;
  my $count = 0;
  my $details = q{};
  foreach my $i ( 0 .. $#$nums - 2 ) {
    foreach my $j ( $i + 1 .. $#$nums - 1 ) {
      next unless $nums->[$j] - $nums->[$i] == $diff;
      foreach my $k ( $j + 1 .. $#$nums ) {
        next unless $nums->[$k] - $nums->[$j] == $diff;
        $count++;
        $details .= "($i, $j, $k) is an arithmetic triplet "
          .  "because both $nums->[$k] - $nums->[$j] = $diff "
          .  "and $nums->[$j] - $nums->[$i] = $diff\n";
      }
    }
  }
  return ($count, $details);
}

sub solution {
  my($diff, $nums) = @_;
  say 'Input: @nums = (' . join(', ', @$nums) . ')';
  say '       $diff = ' . $diff;
  my ($count, $details) = findTriplets($diff, $nums);
  say "Output: $count\n\n$details";
}

say "Example 1:";
solution(3, [0, 1, 4, 6, 7, 10]);

say "\nExample 2:";
solution(2, [4, 5, 6, 7, 8, 9]);