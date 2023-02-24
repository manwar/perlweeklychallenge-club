#!/usr/bin/env raku

sub third-highest(@arr)
{
  my @sorted = @arr.unique.sort: {$^b <=> $^a};
  @sorted[2] // @sorted[0];
}

say third-highest([5,3,4]);
say third-highest([5,6]);
say third-highest([5,4,4,3]);

