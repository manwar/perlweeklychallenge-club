import std.stdio:writeln,stderr;
import std.format:format;
import core.stdc.stdlib:exit;

string first_unique_character(string str)
{
  string ret;
  char[] chars = str.dup;
  int[char] hash;
  foreach(c;chars)
    hash[c]++;
  for(ulong i = 0; i < chars.length; ++i)
    if(hash[chars[i]] == 1)
    {
      ret = format("%u as '%c' is the first unique character",
		   i,
		   chars[i]);
      break;
    }
  return ret;
}

void main(string[] args)
{
  if(args.length != 2)
  {
    stderr.writeln("no arg(s) provided!");
    exit(1);
  }
  writeln(first_unique_character(args[1]));
}

