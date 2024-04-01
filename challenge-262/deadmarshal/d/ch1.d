import std.stdio:writeln;
import std.algorithm:max;

size_t max_positive_negative(int[] arr)
{
  size_t neg = 0, pos = 0;
  foreach(ref e;arr) if(e < 0) neg++; else pos++;
  return max(neg,pos);
}

void main()
{
  int[] arr1 = [-3,1,2,-1,3,-2,4];
  int[] arr2 = [-1,-2,-3,1];
  int[] arr3 = [1,2];
  writeln(max_positive_negative(arr1));
  writeln(max_positive_negative(arr2));
  writeln(max_positive_negative(arr3));
}

