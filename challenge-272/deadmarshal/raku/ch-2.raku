#!/usr/bin/env raku

sub string-score($str)
{
  my @arr = $str.ords;
  my $sum = 0;
  for 0..^@arr.end -> $i {
    $sum += abs(@arr[$i+1] - @arr[$i])
  }
  $sum
}

say string-score('hello');
say string-score('perl');
say string-score('raku');

