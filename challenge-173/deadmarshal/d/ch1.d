import std.stdio;

int uabs(int a, int b)
{
  if(a < b) return b - a;
  return a - b;
}

bool is_esthetic_number(int n)
{
  if(n == 0) return false;
  int i = n % 10;
  n /= 10;
  while(n)
  {
    int j = n % 10;
    if(uabs(i, j) != 1) return false;
    n /= 10;
    i = j;
  }
  return true;
}

void main()
{
  writefln("Is %d an esthetic number? %s",
	   5456,
	   is_esthetic_number(5456));
  writefln("Is %d an esthetic number? %s",
	   120,
	   is_esthetic_number(120));  
}
