import std.stdio:writeln;

short digital_clock(string str)
{
  return str[0] == '?' ? (str[1] - '0' < 4 ? 2 : 1)
    : str[1] == '?' ? (str[0] - '0' < 2 ? 9 : 3)
    : str[3] == '?' ? 5 : 9;
}

void main()
{
  writeln(digital_clock("?5:00"));
  writeln(digital_clock("?3:00"));
  writeln(digital_clock("1?:00"));
  writeln(digital_clock("2?:00"));
  writeln(digital_clock("12:?5"));
  writeln(digital_clock("12:5?"));
}
	 
