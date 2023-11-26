import std.stdio:writeln;

int[][] conflict_intervals(ref int[][] arr)
{
  int[][] ret;
  for(ulong i = 1; i < arr.length; ++i)
  {
    bool b = false;
    for(ulong j = 0; j < i; ++j)
      if(arr[i][0] >= arr[j][0] && arr[i][0] <= arr[j][1]) b = true;
    if(b) ret ~= arr[i];
  }
  return ret;
}

void main()
{
  int[][] arr = [[1,4],[3,5],[6,8],[12,13],[3,20]];
  int[][] arr2 = [[3,4],[5,7],[6,9],[10,12],[13,15]];
  writeln(conflict_intervals(arr));
  writeln(conflict_intervals(arr2));
}

