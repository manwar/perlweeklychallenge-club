import std.stdio:writeln;

void move_zero(int[] arr)
{
  int count = 0;
  for(int i = 0; i < arr.length; ++i)
    if(arr[i] != 0) arr[count++] = arr[i];
  while(count < arr.length) arr[count++] = 0;
}

void main()
{
  int[] a1 = [1,0,3,0,0,5];
  int[] a2 = [1,6,4];
  int[] a3 = [0,1,0,2,0];
  move_zero(a1);
  move_zero(a2);
  move_zero(a3);
  writeln(a1);
  writeln(a2);
  writeln(a3);
}

