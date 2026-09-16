module ch1;

import std::sort;
import std::core::mem::alloc;

fn double array_median(Allocator allocator,int[] a1,int[] a2)
{
  int[] merged = array::concat(allocator,a1,a2);
  defer alloc::free(allocator,merged);
  if(merged.len == 0) return 0.0;

  sort::quicksort(merged);
  
  if(merged.len % 2 == 1)
  {
    return merged[merged.len / 2];
  }
  else
  {
    int left_middle = merged.len / 2 - 1;
    return (double)(merged[left_middle] + merged[left_middle+1]) / 2;
  }
}

fn int main(String[] args)
{
  return 0;
}

