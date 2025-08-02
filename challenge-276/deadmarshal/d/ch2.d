import std.stdio:writeln;
import std.algorithm:maxElement,filter,sum;
import std.array:array;

int maximum_frequency(int[] arr)
{
  int sum = 0;
  int[int] h;
  foreach(e;arr) h[e]++;
  int max = h.values.maxElement;
  return h.values.filter!(a => a == max).array.sum;
}

void main()
{
  writeln(maximum_frequency([1,2,2,4,1,5]));
  writeln(maximum_frequency([1,2,3,4,5]));
}

