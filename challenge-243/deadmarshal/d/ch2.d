import std.stdio:writeln;

ulong floor_sum(ref int[] arr)
{
  ulong sum = 0;
  for(ulong i = 0; i < arr.length; ++i)
    for(ulong j = 0; j < arr.length; ++j)
      sum += int(arr[i] / arr[j]);
  return sum;
}

void main()
{
  int[] arr1 = [2,5,9];
  int[] arr2 = [7,7,7,7,7,7,7];
  writeln(floor_sum(arr1));
  writeln(floor_sum(arr2));
}

