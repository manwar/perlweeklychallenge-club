import std.stdio;
import std.math:sqrt;

bool is_prime(int n)
{
  if(n <= 1) return false;
  for(int i = 2; i <= cast(int)sqrt(cast(float)n); ++i)
    if(n % i == 0) return false;
  return true;
}

int reverse_num(int n)
{
  int rev = 0, rem;
  while(n)
  {
    rem = n % 10;
    rev = rem + (rev * 10);
    n /= 10;
  }
  return rev;
}

void main()
{
  foreach(int i; 1..1000)
    if((i == reverse_num(i)) && (is_prime(i)))
      write(i, ' ');
}
