#! /usr/bin/env raku

unit sub MAIN ($arr1, $arr2, :v(:$verbose));

my @arr1   = $arr1.words>>.Numeric;
my @arr2   = $arr2.words>>.Numeric;
my @sorted = merge-sort(@arr1, @arr2);
my $index  = (@sorted.elems - 1) div 2;
my $single = @sorted.elems % 2;

if $verbose
{
  say ": Merged: @sorted[]";
  say ": Median index: $index" ~ ( $single ?? "" !! "+" );
}

say $single
  ?? @sorted[$index]
  !! (@sorted[$index] + @sorted[$index +1]) / 2;

sub merge-sort (@arr1 is copy, @arr2 is copy)
{
  return gather
  {
    while @arr1.elems || @arr2.elems
    {
      if @arr1.elems && @arr2.elems
      {
        @arr1[0] < @arr2[0]
          ?? take @arr1.shift
	  !! take @arr2.shift;
      }
      elsif @arr1.elems
      {
        take @arr1.shift;
      }
      else # @arr2.elems
      {
        take @arr2.shift;
      }
    }
  }
}

