import std.stdio:writeln;

int exact_change(int[] arr)
{
  int[int] hash;
  foreach(e;arr)
  {
    if(e == 10) if(!--hash[5]) return false;
    else if(e == 20)
    {
      if(hash[5] && hash[10])
      {
	hash[5]--;
	hash[10]--;
      }
      else if(hash[5] > 2) hash[5] -= 3;
      else return false;
    }
    hash[e]++;
  }
  return true;
}

void main()
{
  writeln(exact_change([5,5,5,10,20]));
  writeln(exact_change([5,5,10,10,20]));
  writeln(exact_change([5,5,5,20]));
}

