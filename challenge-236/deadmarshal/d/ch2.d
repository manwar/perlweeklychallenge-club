import std.stdio:writeln;

ulong array_loops(ref int[] arr)
{
  ulong count = 0,i = 0;
  int[] indices = new int[arr.length];
  indices[] = -1;
  while(i < arr.length)
  {
    if(indices[i] == -1)
    {
      count++;
      while(indices[i] == -1)
      {
	indices[i] = 1;
	i = arr[i];
      }
    }
    i++;
  }
  return count;
}

void main()
{
  int[] arr1 = [4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10];
  int[] arr2 = [0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19];
  int[] arr3 = [9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17];
  writeln(array_loops(arr1));
  writeln(array_loops(arr2));
  writeln(array_loops(arr3));
}

