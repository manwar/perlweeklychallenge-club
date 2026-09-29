module ch1;

import std::io;
import std::math;

fn int pythagoras_multiplied(int n)
{
  int count;
  for(int m = 2; m * m + 1 <= n; m++)
  {
    for(int k = 1; k < m; k++)
    {
      if((m - k) % 2 == 0 || math::gcd(m,k) != 1) continue;
      int c = m * m + k * k;
      if(c > n && k == 1) break;
      if(c > n) continue;
      count += 2 * (n / c);
    }
  }
  return count;
}

fn int main(String[] args)
{
  io::printn(pythagoras_multiplied(20));
  io::printn(pythagoras_multiplied(7));
  io::printn(pythagoras_multiplied(1));
  io::printn(pythagoras_multiplied(15));
  io::printn(pythagoras_multiplied(30));
  return 0;
}

