import std.stdio:writeln;

const int N = 5;
static int count = 0;

void find_combinations(int[N] arr,
		       int index,
		       int num,
		       int reduced_num)
{
  if(reduced_num < 0) return;
  if(reduced_num == 0)
  {
    count++;
    return;
  }
  int prev = index == 0 ? 1 : arr[index-1];
  for(int i = prev; i <= num; ++i)
  {
    arr[index] = i;
    find_combinations(arr,index+1,num,reduced_num-i);
  }
}

void main()
{
  int[N] arr;
  find_combinations(arr,0,N,N);
  writeln(count);
}

