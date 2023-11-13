#include<stdio.h>
#include<math.h> // -lm

struct Interval
{
  int x,y;
};

void conflict_intervals(struct Interval *arr,size_t sz)
{
  for(size_t i = 1; i < sz; ++i)
  {
    int b = 0;
    for(size_t j = 0; j < i; ++j)
    {
      if((arr[i].x >= arr[j].x) && (arr[i].x <= arr[j].y))
	b = 1;
    }
    if(b) printf("(%d %d) ",arr[i].x,arr[i].y);
  }
  puts("");
}

int main(void)
{
  struct Interval arr[] = {{1,4},{3,5},{6,8},{12,13},{3,20}};
  struct Interval arr2[] = {{3,4},{5,7},{6,9},{10,12},{13,15}};
  size_t sz = sizeof(arr)/sizeof(*arr);
  conflict_intervals(arr,sz);
  conflict_intervals(arr2,sz);
  return 0;
}

