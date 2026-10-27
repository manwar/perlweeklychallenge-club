module ch1;

import std::io,std::math,std::collections;

fn int absent_smallest_positive(Allocator allocator,int[] arr)
{
  int sum = 0;
  HashSet{int} h;
  h.init(allocator);

  foreach(e : arr)
  {
    h.add(e);
    sum += e;
  }
  
  int ret = math::max(1,(int)(sum / arr.len) + 1);
  while(h.contains(ret)) ret++;
  return ret;
}

fn int main(String[] args)
{
  @pool()
  {
    io::printn(absent_smallest_positive(mem,{1,2,4,5,6}));
    io::printn(absent_smallest_positive(mem,{-5,-2,-1,3}));
    io::printn(absent_smallest_positive(mem,{1,2,3}));
    io::printn(absent_smallest_positive(mem,{2,3,7,8}));
    io::printn(absent_smallest_positive(mem,{1,1,1,10}));
  };
  return 0;
}

