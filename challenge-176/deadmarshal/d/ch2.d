import std.stdio:write;
import std.algorithm:all;

int reverse_num(int n)
{
  int res;
  while(n)
  {
    res = (res * 10) + (n % 10);
    n /= 10;
  }
  return res;
}

int[] split_num(int n)
{
  int[] arr;
  while(n)
  {
    arr ~= n % 10;
    n /= 10;
  }
  return arr;
}

bool is_reversible_number(int n)
{
  int sum = n + reverse_num(n);
  int[] arr = split_num(sum);
  if(all!(a => a % 2 != 0)(arr)) return true;
  return false;
}

void main()
{
  int i = 1;
  while(i < 100)
  {
    if(is_reversible_number(i)) write(i, ' ');
    i++;
  }
}
