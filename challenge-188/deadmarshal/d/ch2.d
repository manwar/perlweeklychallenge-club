import std.stdio:writeln;

int total_zero(int x, int y)
{
  int count = 0;
  while((x > 0) && (y > 0))
  {
    (x > y) ? (x -= y) : (y -= x);
    count++;
  }
  return count;
}

void main()
{ 
  writeln(total_zero(5,4));
  writeln(total_zero(4,6));
  writeln(total_zero(2,5));
  writeln(total_zero(3,1));
  writeln(total_zero(7,4));
}
