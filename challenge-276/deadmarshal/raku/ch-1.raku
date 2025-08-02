#!usr/bin/env raku

sub complete-day(@arr){
  my $count = 0;
  for 0..^@arr.end -> $i {
    for $i+1..@arr.end -> $j {
      $count++ if (@arr[$i] + @arr[$j]) %% 24
    }
  }
  $count
}

say complete-day([12,12,30,24,24]);
say complete-day([72,48,24,55]);
say complete-day([12,18,24]);
