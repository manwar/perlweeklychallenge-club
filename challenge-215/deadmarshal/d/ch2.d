import std.stdio:writeln;

bool number_placement(int[] arr, size_t count)
{
  size_t c = 0;
  for(size_t i = 1; i < arr.length-1; ++i)
    if(arr[i-1] == 0 && arr[i+1] == 0) c++;
  return c >= count;
}

void main()
{
  int[] a1 = [1,0,0,0,1];
  int[] a2 = [1,0,0,0,1];
  int[] a3 = [1,0,0,0,0,0,0,0,1];
  writeln(number_placement(a1,1));
  writeln(number_placement(a2,2));
  writeln(number_placement(a3,3)); 
}

