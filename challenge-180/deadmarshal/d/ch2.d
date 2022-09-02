import std.stdio:writeln;
import std.format:format;
import std.algorithm:map,filter;
import std.array:array,join;
import std.conv:to;

void main()
{
  int[] n = [1,4,2,3,5];
  int[] n2 = [9,0,6,2,3,8,5];
  int i = 3, i2 = 4;
  writeln(format("(%s)",
		 filter!(a => a > i)(n)
		 .array
		 .map!(a => to!string(a))
		 .join(",")));
  writeln(format("(%s)",
		 filter!(a => a > i2)(n2)
		 .array
		 .map!(a => to!string(a))
		 .join(",")));
}
