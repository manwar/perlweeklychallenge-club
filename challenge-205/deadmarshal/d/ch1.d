import std.stdio:writeln;
import std.algorithm:uniq,sort;
import std.array:array;

int third_highest(ref int[] arr)
{
  int[] sorted = arr.uniq.array.sort!("a > b").array;
  return sorted.length < 3 ? sorted[0] : sorted[2];
}

void main()
{
  int[] a1 = [5,3,4];
  int[] a2 = [5,6];
  int[] a3 = [5,4,4,3];
  writeln(third_highest(a1));
  writeln(third_highest(a2));
  writeln(third_highest(a3));
}

