import std.stdio:writeln;
import std.algorithm:sort;
import std.math:abs;

int max_gap(int[] arr)
{
  if(arr.length < 2) return 0;
  arr.sort;
  int i = 0,max = 0,count = 0,temp = 0;
  while(i < arr.length)
  {
    temp = abs(arr[i] - arr[i+1]);
    if(temp > max) max = temp;
    i += 2;
  }
  for(i = 0; i < arr.length-1; ++i)
    if(abs(arr[i] - arr[i+1]) == max) count++;
  return count;
}

void main()
{
  int[] a1 = [2,5,8,1];
  int[] a2 = [3];
  writeln(max_gap(a1));
  writeln(max_gap(a2));
}

