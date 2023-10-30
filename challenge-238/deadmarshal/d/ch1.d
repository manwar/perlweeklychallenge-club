import std.stdio:write,writeln;

void running_sum(ref int[] arr)
{
  int sum = 0;
  foreach(ref e;arr)
  {
    sum += e;
    write(sum,' ');
  }
  writeln;
}

void main()
{
  int[] arr1 = [1,2,3,4,5];
  int[] arr2 = [1,1,1,1,1];
  int[] arr3 = [0,-1,1,2];
  running_sum(arr1);
  running_sum(arr2);
  running_sum(arr3);
}

