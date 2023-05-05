import std.stdio:writeln;

bool is_alphabetical_order(string str)
{
  for(size_t i = 1; i < str.length; ++i)
    if(str[i] < str[i-1]) return false;
  return true;
}

int odd_one_out(string[] arr)
{
  int count = 0;
  foreach(s;arr) if(!is_alphabetical_order(s)) count++;
  return count;
}

void main()
{
  writeln(odd_one_out(["abc", "xyz", "tsu"]));
  writeln(odd_one_out(["rat", "cab", "dad"]));
  writeln(odd_one_out(["x","y","z"]));
}

