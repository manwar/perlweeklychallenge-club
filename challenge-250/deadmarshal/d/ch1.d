import std.stdio;

int smallest_index(int[] arr)
{
  foreach(i;0..arr.length) if(i % 10 == arr[i]) return cast(int)i;
  return -1;
}

void main()
{
  int[] arr1 = [0,1,2];
  int[] arr2 = [4,3,2,1];
  int[] arr3 = [1,2,3,4,5,6,7,8,9,0];
  writeln(smallest_index(arr1));
  writeln(smallest_index(arr2));
  writeln(smallest_index(arr3));
}

