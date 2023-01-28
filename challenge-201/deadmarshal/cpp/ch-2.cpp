#include<iostream>

#define N 5
static int count{};

void find_combinations(int *arr,
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

int main()
{
  int arr[N];
  find_combinations(arr,0,N,N);
  std::cout << count << '\n';
}

