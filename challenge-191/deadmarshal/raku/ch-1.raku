sub twice-largest(@arr)
{
  @arr = @arr.sort.reverse;
  @arr[0] >= 2 * @arr[1] ?? 1 !! -1;
}

say twice-largest([1,2,3,4]);
say twice-largest([1,2,0,5]);
say twice-largest([2,6,3,1]);
say twice-largest([4,5,2,3]);

