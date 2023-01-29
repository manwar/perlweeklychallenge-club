import std.stdio:write,writeln;

void missing_numbers(int[] arr)
{
  int[int] m;
  foreach(const ref i;arr) m[i] = i;
  for(int i = 0; i <= arr.length; ++i)
    if(i !in m) write(i, ' ');
  writeln;
}

void main()
{
  missing_numbers([0,1,3]);
  missing_numbers([0,1]);
}

