import std.stdio:writeln;

int complete_day(int[] arr)
{
  int count = 0;
  foreach(i;0..arr.length-1)
    foreach(j;i+1..arr.length)
      if((arr[i] + arr[j]) % 24 == 0) count++;
  return count;
}

void main()
{
  writeln(complete_day([12,12,30,24,24]));
  writeln(complete_day([72,48,24,55]));
  writeln(complete_day([12,18,24]));
}

