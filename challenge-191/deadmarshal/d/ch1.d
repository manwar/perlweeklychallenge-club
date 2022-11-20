import std.stdio:writefln;
import std.algorithm:sort;

int twice_largest(ref int[] arr)
{
  arr.sort!("a > b");
  return arr[0] >= (2 * arr[1]) ? 1 : -1;
}

void main()
{
  int[] a1 = [1,2,3,4];
  int[] a2 = [1,2,0,5];
  int[] a3 = [2,6,3,1];
  int[] a4 = [4,5,2,3];
  writefln("%2d", twice_largest(a1));
  writefln("%2d", twice_largest(a2));
  writefln("%2d", twice_largest(a3));
  writefln("%2d", twice_largest(a4));
}

