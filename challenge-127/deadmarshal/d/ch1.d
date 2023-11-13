import std.stdio:writeln;
import std.algorithm:all;

bool disjoint_sets(ref int[] arr1,ref int[] arr2)
{
  int[int] h;
  for(int i = 0; i < arr1.length; ++i)
  {
    h[arr1[i]]++;
    h[arr2[i]]++;
  }
  if(h.values.all!(a => a == 1)) return true;
  return false;
}

void main()
{
  int[] arr1 = [1,2,5,3,4], arr2 = [4,6,7,8,9];
  int[] arr3 = [1,3,5,7,9], arr4 = [0,2,4,6,8];
  writeln(disjoint_sets(arr1,arr2));
  writeln(disjoint_sets(arr3,arr4));
}

