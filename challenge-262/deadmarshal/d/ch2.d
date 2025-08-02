import std.stdio:writeln;

size_t count_equal_divisible(int[] arr, int k)
{
  size_t count = 0;
  foreach(i;0..arr.length-2){
    foreach(j;i+1..arr.length-1){
      if((arr[i] == arr[j] && ((i*j) % k == 0))) ++count;
    }
  }
  return count;
}

void main()
{
  int[] arr = [1,3,2,2,2,1,3];
  int[] arr2 = [1,2,3];
  writeln(count_equal_divisible(arr,2));
  writeln(count_equal_divisible(arr2,1));
}

