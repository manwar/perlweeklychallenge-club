import std.stdio:writeln,write;
import std.algorithm:sort;

int product(int n)
{
  int prod = 1;
  while(n)
  {
    prod *= n % 10;
    n /= 10;
  }
  return prod;
}

int helper(int n)
{
  int sum = 0;
  while(n >= 10)
  {
    sum++;
    n = product(n);
  }
  return sum;
}

bool compare(int a, int b)
{
  int ha = helper(a);
  int hb = helper(b);
  return ha == hb ? a < b : ha < hb;
}

void persistence_sort(ref int[] arr)
{
  arr.sort!(compare);
}

void main()
{
  int[] arr1 = [15,99,1,34];
  int[] arr2 = [50,25,33,22];
  persistence_sort(arr1);
  persistence_sort(arr2);
  writeln(arr1);
  writeln(arr2);
}

