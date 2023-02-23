import std.stdio:writeln;

int maximum_xor(int[] arr)
{
  int max = 0;
  for(size_t i = 0; i < arr.length; ++i)
    for(size_t j = 0; j < arr.length; ++j)
    {
      int temp = arr[i] ^ arr[j];
      if(max < temp) max = temp;
    }
  return max;
}

void main()
{
  writeln(maximum_xor([1,2,3,4,5,6,7]));
  writeln(maximum_xor([2,4,1,3]));
  writeln(maximum_xor([10,5,7,12,8]));
}

