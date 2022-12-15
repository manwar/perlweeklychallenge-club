import std.stdio:writeln;
import std.algorithm:sort;

bool frequency_equalizer(string str)
{
  uint[char] hash;
  int[] vals;
  foreach(c;str) hash[c]++;
  foreach(k,v;hash) vals ~= v;
  vals.sort!("a > b");
  if((vals[0] == vals[1]+1) && (vals[$-1] == vals[1])) return true;
  return false;
}

void main()
{
  writeln(frequency_equalizer("abbc"));
  writeln(frequency_equalizer("xyzyyxz"));
  writeln(frequency_equalizer("xzxz")); 
}

