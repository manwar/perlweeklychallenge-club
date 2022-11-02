import std.stdio:write,writeln;

void array_degree(const ref int[] arr)
{
  int[int] left,count;
  int x,min,max,index;
  for(int i = 0; i < arr.length; ++i)
  {
    x = arr[i];
    if(x !in count)
    {
      left[x] = i;
      count[x] = 1;
    }
    else count[x]++;

    if(count[x] > max)
    {
      max = count[x];
      min = i - left[x] + 1;
      index = left[x];
    }
    else if((count[x] == max) && (i - left[x] + 1 < min))
    {
      min = i - left[x] + 1;
      index = left[x];
    }
  }
  for(int i = index; i < index+min; ++i)
    write(arr[i], ' ');
  writeln;
}

void main()
{
  int[] arr1 = [1,3,3,2];
  int[] arr2 = [1,2,1,3];
  int[] arr3 = [1,3,2,1,2];
  int[] arr4 = [1,1,2,3,2];
  int[] arr5 = [2,1,2,1,1];
  array_degree(arr1);
  array_degree(arr2);
  array_degree(arr3);
  array_degree(arr4);
  array_degree(arr5);
}

