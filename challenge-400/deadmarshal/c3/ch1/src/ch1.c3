module ch1;

fn bool has_unique_digits(sz n)
{
  sz seen = 0;
  while(n > 0)
  {
    sz digit = (sz)(n % 10);
    sz bit = (sz)1u << digit;
    if((seen & bit) != 0) return false;
    seen |= bit;
    n /= 10;
  }
  return true;
}

fn sz largest_interval(sz n)
{
  sz jump;
  sz prev;

  for(sz i = 1; i <= n; i++)
  {
    if(!has_unique_digits(i)) continue;
    if(prev != 0 && i - prev > jump) jump = i - prev;
    prev = i;
  }
  return jump;
}

