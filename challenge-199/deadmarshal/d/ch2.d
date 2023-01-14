import std.stdio:writeln;
import std.math:abs;

int good_pairs(int[] arr, int x, int y, int z)
{
  int count = 0;
  for(size_t i = 0; i < arr.length; ++i)
    for(size_t j = 0; j < arr.length; ++j)
      for(size_t k = 0; k < arr.length; ++k)
	if((abs(arr[i] - arr[j]) <= x) &&
	   (abs(arr[j] - arr[k]) <= y) &&
	   (abs(arr[i] - arr[k]) <= z) &&
	   (0 <= i) &&
	   (i < j) &&
	   (j < k) &&
	   (k <= arr.length)) count++;
  return count;
}
  
void main()
{
  writeln(good_pairs([3,0,1,1,9,7],7,2,3));
  writeln(good_pairs([1,1,2,2,3],0,0,1));
}
