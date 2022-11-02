import std.stdio:writeln;
import std.algorithm:sort;

dchar greater_character(dchar[] arr, dchar target)
{
  arr.sort();
  for(size_t i = 0; i < arr.length; ++i)
    if(arr[i] > target) return arr[i];
  return target;
}

void main()
{
  writeln(greater_character(['e','m','u','g'], 'b'));
  writeln(greater_character(['d','c','e','f'], 'a'));
  writeln(greater_character(['j','a','r'], 'o'));
  writeln(greater_character(['d','c','a','f'], 'a'));
  writeln(greater_character(['t','g','a','l'], 'v'));
}
