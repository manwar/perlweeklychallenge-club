import std.stdio:writeln;
import std.algorithm:map,filter,count;
import std.conv:to;
import std.array:array;

ulong senior_citizens(ref string[] arr)
{
  return arr.map!(a => a[$-4..$-2].to!(int))
    .filter!(a => a >= 60)
    .count;
}

void main()
{
  string[] arr1 = ["7868190130M7522",
		   "5303914400F9211",
		   "9273338290F4010"];
  string[] arr2 = ["1313579440F2036",
		   "2921522980M5644"];
  writeln(senior_citizens(arr1));
  writeln(senior_citizens(arr2));
}

