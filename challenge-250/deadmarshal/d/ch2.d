import std.stdio:writeln;
import std.ascii:isDigit;
import std.conv:to;

bool is_numeric(string str)
{
  foreach(i;0..str.length) if(!isDigit(str[i])) return false;
  return true;
}

ulong alphanumeric_string_value(string[] arr)
{
  ulong max = 0;
  foreach(i;0..arr.length)
  {
    ulong n = is_numeric(arr[i]) ? to!int(arr[i]) : arr[i].length;
    if(n > max) max = n;
  }
  return max;
}

void main()
{
  string[] arr1 = ["perl","2","000","python","r4ku"];
  string[] arr2 = ["001","1","000","0001"];
  writeln(alphanumeric_string_value(arr1));
  writeln(alphanumeric_string_value(arr2));
}

