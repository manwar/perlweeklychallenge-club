import std.stdio:writeln;

int h_index(int[] arr)
{
  int ret = 0;
  for(int i = 0; i < arr.length; ++i)
    if(i >= arr[i])
    {
      ret = i;
      break;
    }
  return ret;
}

void main()
{
  writeln(h_index([10,8,5,4,3]));
  writeln(h_index([25,8,5,3,3]));
}

