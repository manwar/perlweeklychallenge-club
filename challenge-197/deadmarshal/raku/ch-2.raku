sub wiggle-sort(@A)
{
  for 0..@A.elems-2 -> $i
  {
    if ($i %% 2) == (@A[$i] > @A[$i+1])
    {
      (@A[$i],@A[$i+1]) = (@A[$i+1],@A[$i]);
    }
  }
  @A;
}

say wiggle-sort([1,5,1,1,6,4]);
say wiggle-sort([1,3,2,2,3,1]);

