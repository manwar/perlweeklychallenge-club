import std.stdio:write,writeln;
import std.algorithm:minElement,maxElement;

void min_max(int[] arr)
{
  if(arr.length < 3)
  {
    writeln(-1);
    return;
  }
  int min = arr.minElement, max = arr.maxElement;
  foreach(e;arr) if(e != min && e != max) write(e,' ');
  writeln;
}

void main()
{ 
  int[] arr1 = [3,2,1,4];
  int[] arr2 = [3,1];
  int[] arr3 = [2,1,3];
  min_max(arr1);
  min_max(arr2);
  min_max(arr3);
}

