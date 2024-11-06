import std.stdio:writeln;
import std.algorithm:nextPermutation;

void main()
{
  int[] arr1 = [1,2,3];
  int[] arr2 = [2,1,3];
  int[] arr3 = [3,1,2];
  nextPermutation(arr1);
  nextPermutation(arr2);
  nextPermutation(arr3);
  writeln(arr1);
  writeln(arr2);
  writeln(arr3);
}

