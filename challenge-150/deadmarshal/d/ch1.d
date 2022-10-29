import std.stdio:writeln;

char fibonacci_words(string a, string b)
{
  string[] arr;
  do{
    arr ~= a ~= b;
  }while(arr[$-1].length < 52);
  return arr[$-1].dup[50];
}

void main()
{
  writeln(fibonacci_words("1234", "5678"));
}
