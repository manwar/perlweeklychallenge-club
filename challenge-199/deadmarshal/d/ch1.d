import std.stdio:writeln;

int good_pairs(int[] arr)
{
  int count = 0;
  for(size_t i = 0; i < arr.length; ++i)
    for(size_t j = i+1; j < arr.length; ++j)
      if(arr[i] == arr[j]) count++;
  return count;
}

void main()
{
  int[] a1 = [1,2,3,1,1,3];
  int[] a2 = [1,2,3];
  int[] a3 = [1,1,1,1];
  writeln(good_pairs(a1));
  writeln(good_pairs(a2));
  writeln(good_pairs(a3));
}

