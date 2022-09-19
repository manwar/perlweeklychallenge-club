import std.stdio:write;

int phi(int n)
{
  int i = 2, result = n;
  while(i <= n)
  {
    if(n % i == 0)
    {
      while(n % i == 0) n /= i;
      result -= (result / i);
    }
    if(i == 2) i = 1;
    i += 2;
  }
  if(n > 1) result -= (result / n);
  return result;
}

int phi_iter(int n)
{
  if(n == 2) return phi(n) + 0;
  return phi(n) + phi_iter(phi(n));
}

void main()
{
  int i = 2, count = 0;
  while(count != 20)
  {
    if(i == phi_iter(i))
    {
      write(i, ' ');
      count++;
    }
    i++;
  }
}
