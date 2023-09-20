#!/usr/bin/env raku

sub is-ascending(@arr)
{
  my $cursor = 0;
  (0..^@arr.end).map({$cursor++ if @arr[$_] < @arr[$_+1]});
  $cursor == @arr.end;
}

sub remove-one(@arr)
{
  my $res = False;
  for 0..@arr.end -> $i {
    my @ret = @arr[0..^$i,$i+1..@arr.end].flat;
    if ($i == 0) {@ret = @arr[1..@arr.end]}
    elsif ($i == @arr.end) {@ret = @arr[0..^@arr.end]}
    $res = True if is-ascending(@ret);
  }
  $res
}

say remove-one([0,2,9,4,5]);
say remove-one([5,1,3,2]);
say remove-one([2,2,3]);

