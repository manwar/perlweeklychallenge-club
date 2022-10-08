import std.stdio:writeln;
import std.array:replace,insertInPlace;

string mac_address(string str)
{
  string ret = str;
  ret = ret.replace(".", "");
  int i = 2;
  while(i < ret.length)
  {
    insertInPlace(ret, i, ":");
    i += 3;
  }
  return ret;
}

void main()
{
  string s1 = "1ac2.34f0.b1c2";
  string s2 = "abc1.20f1.345a";
  writeln(mac_address(s1));
  writeln(mac_address(s2));
}
