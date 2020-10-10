#! /usr/bin/perl6

use Test;

plan 2;

is(cc((1,2,2)),4,'example 1');
is(cc((1,4,3,2)),7,'example 2');

sub cc(@list) {
  my @n=sort {@list[$^a] <=> @list[$^b]}, (0..@list.end);
  my @k;
  for @n -> $i {
    my @nr=(1);
    if ($i > 0 && @list[$i-1] < @list[$i]) {
      if (defined @k[$i-1]) {
        push @nr,@k[$i-1]+1;
      }
    }
    if ($i < @list.end && @list[$i+1] < @list[$i]) {
      if (defined @k[$i+1]) {
        push @nr,@k[$i+1]+1;
      }
    }
    @k[$i]=max(@nr);
  }
  return sum(@k);
}
