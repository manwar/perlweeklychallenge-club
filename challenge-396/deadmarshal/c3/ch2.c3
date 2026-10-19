module ch2;

import std::io;

fn bool trionic_array(int[] arr)
{
  sz p;
  sz n = arr.len;
  while(p < n-2 && arr[p] < arr[p+1]) p++;
  if(p == 0) return false;
  sz q = p;
  while(q < n-1 && arr[q] > arr[q+1]) q++;
  if(q == p || q == n-1) return false;
  while(q < n-1 && arr[q] < arr[q+1]) q++;
  return q == n-1;
}

fn int main(String[] args)
{
  io::printn(trionic_array({1,3,5,4,2,6,8}));
  io::printn(trionic_array({1,4,4,2,1,3,5}));
  io::printn(trionic_array({2,10,3,1,9}));
  io::printn(trionic_array({1,2,3,4,3,2,1}));
  io::printn(trionic_array({1,3,6,4,2,7,8,4}));
  return 0;
}

