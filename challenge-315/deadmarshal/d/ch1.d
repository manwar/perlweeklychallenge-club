import std.stdio:writeln;
import std.string:indexOf;

ulong[] find_words(string[] arr,char c)
{
  ulong[] ret;
  foreach(ref i,e;arr) if(indexOf(e,c) != -1) ret ~= i;
  return ret;
}

void main()
{
  writeln(find_words(["the", "weekly", "challenge"],'e'));
  writeln(find_words(["perl", "raku", "python"],'p'));
  writeln(find_words(["abc", "def", "bbb", "bcd"],'b'));
}

