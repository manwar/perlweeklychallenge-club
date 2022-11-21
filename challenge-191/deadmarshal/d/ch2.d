import std.stdio:writeln;
import std.algorithm:swap;

bool is_cute(const ref int[] arr)
{
  for(size_t i = 1; i <= arr.length; ++i)
    if((i % arr[i-1]) && (arr[i-1] % i)) return false;
  return true;
}

void permute(ref int[] arr, int i, size_t sz, int *count)
{
  if(sz == i)
  {
    if(is_cute(arr)) (*count)++; 
    return;
  }
  for(size_t j = i; j < sz; ++j)
  {
    swap(arr[i], arr[j]);
    permute(arr,i+1,sz,count);
    swap(arr[i], arr[j]);
  }
}

void main()
{
  int[] arr = [1,2];
  int count = 0;
  permute(arr,0,2,&count);
  writeln(count);
}

