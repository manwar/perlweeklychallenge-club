import std.stdio:write,writeln;
import std.algorithm:sum;
import std.math:abs;

void left_right_sum_diff(const ref int[] arr)
{
  int left = 0, right = arr[1..$].sum;
  foreach(i; 0..arr.length)
  {
    write(abs(left - right), ' ');
    left += arr[i];
    right -= i < arr.length-1 ? arr[i+1] : 0;
  }
  writeln;
}

void main()
{
  int[] a1 = [10,4,8,3];
  int[] a2 = [1];
  int[] a3 = [1,2,3,4,5];
  left_right_sum_diff(a1);
  left_right_sum_diff(a2);
  left_right_sum_diff(a3);
}

