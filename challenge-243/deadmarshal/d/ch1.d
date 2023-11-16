import std.stdio:writeln;

int reverse_pairs(ref int[] arr)
{
  int count = 0;
  foreach(i;0..arr.length)
    foreach(j;i+1..arr.length)
      if(arr[i] > 2 * arr[j]) count++;
  return count;
}

void main()
{
  int[] arr1 = [1,3,2,3,1];
  int[] arr2 = [2,4,3,5,1];
  writeln(reverse_pairs(arr1));
  writeln(reverse_pairs(arr2));
}

