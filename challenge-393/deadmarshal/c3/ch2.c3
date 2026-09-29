module ch2;

import std::io;
import std::math;

fn bool is_prime(int n)
{
  if(n <= 1) return false;
  for(int i = 2; i <= math::sqrt(n); i++) if(n % i == 0) return false;
  return true;
}

fn int prime_step(String s)
{
  int sum,d;
  foreach(c : s) sum += c;
  while(true)
  {
    if(is_prime(sum - d) || is_prime(sum + d)) return d;
    d++;
  }
}

fn int main(String[] args)
{
  io::printn(prime_step("hello"));
  io::printn(prime_step("football"));
  io::printn(prime_step("a"));
  io::printn(prime_step("challenge"));
  io::printn(prime_step("perl"));
  return 0;
}

