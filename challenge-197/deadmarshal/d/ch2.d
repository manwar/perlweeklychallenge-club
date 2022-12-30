import std.stdio:writeln;
import std.algorithm:swap;

void wiggle_sort(int[] arr)
{
  for(int i = 0; i < arr.length-1; ++i)
    if((i % 2 == 0) == (arr[i] > arr[i+1])) swap(arr[i],arr[i+1]);
}

void main()
{
  int[] a1 = [1,5,1,1,6,4];
  int[] a2 = [1,3,2,2,3,1];
  wiggle_sort(a1);
  wiggle_sort(a2);
  writeln(a1);
  writeln(a2);
}

