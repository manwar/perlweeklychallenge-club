import std.stdio;
import std.math:pow;

int sum_squares(int n)
{
  int sum = 0;
  while(n)
  {
    sum += cast(int)pow(n % 10, 2);
    n /= 10;
  }
  return sum;
}

bool is_happy(int n)
{
  int[int] map;
  while(1)
  {
    map[n]++;
    n = sum_squares(n);
    if(n == 1) return true;
    if(n in map) return false;
  }
}

void happy_numbers()
{
  int i = 0, count = 0;
  while(count < 8)
  {
    if(is_happy(i))
    {
      write(i, ' ');
      count++;
    }
    i++;
  }
}

void main()
{
  happy_numbers();
}
