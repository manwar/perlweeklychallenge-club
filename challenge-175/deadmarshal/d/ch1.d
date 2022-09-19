import std.stdio:writefln,stderr;
import std.conv:to;

int main(string[] args)
{
  int[] months = [31,29,31,30,31,30,31,31,30,31,30,31];
  int year, week;
  if((args.length < 2) || (year = to!int(args[1])) <= 1752)
  {
    stderr.writeln("No arg(s) provided or is less than 1752!");
    return 1;
  }
  months[1] -= (year % 4) || (!(year % 100) && (year % 400));
  week = year * 365 + 97 * (year-1) + 4;
  foreach(int month; months){
    week = (week + month) % 7;
    writefln("%d-%02d-%d", year, month+1, month - week);
  }
  return 0;
}
