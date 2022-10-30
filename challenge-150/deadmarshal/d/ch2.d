import std.stdio:write;
import std.algorithm:uniq;
import std.array:array;

ulong[] prime_factors(ulong n)
{
  ulong c = 2;
  ulong[] arr;
  while(n > 1)
  {
    if(n % c == 0)
    {
      arr ~= c;
      n /= c;
    }
    else c++;
  }
  return arr;
}

void square_free_integers()
{
  ulong i = 1;
  do{
    ulong[] primes = prime_factors(i);
    ulong prime = primes.uniq().array.length;
    if(primes.length - prime == 0) write(i, ' ');
    i++;
  }while(i <= 500);
}

void main()
{
  square_free_integers();
}
