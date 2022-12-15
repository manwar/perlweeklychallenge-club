import std.stdio:writeln;

bool has_dups(int n)
{
  int[int] hash;
  while(n)
  {
    if(hash.require(n%10,0)) return true;
    hash[n%10] = 1;
    n /= 10;
  }
  return false;
}

int special_integers(int n)
{
  int count = 0;
  for(int i = 1; i <= n; ++i) if(!has_dups(i)) count++;
  return count;
}

void main()
{
  writeln(special_integers(15));
  writeln(special_integers(35));
}

