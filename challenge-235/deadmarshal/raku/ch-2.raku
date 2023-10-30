#!/usr/bin/env raku

sub duplicate-zeros(@arr)
{
  my @ret;
  for @arr {
    last if @ret.elems == @arr.elems;
    $_ == 0 ?? @ret.splice: @ret.elems,0,0,0 !! @ret.push: $_;
  }
  @ret
}

say duplicate-zeros([1,0,2,3,0,4,5,0]);
say duplicate-zeros([1,2,3]);
say duplicate-zeros([0,3,0,4,5]);

