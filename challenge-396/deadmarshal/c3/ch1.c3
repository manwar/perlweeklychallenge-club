module ch1;

import std::io;
import std::collections;

fn List{int} finishing_order(Allocator allocator,int[] a,int[] b)
{
  HashMap{int,bool} h;
  h.tinit();
  foreach(s : b) h.set(s,true);
  List{int} res;
  res.init(allocator);
  foreach(s : a) if(h.has_key(s)) res.push(s);
  return res;
}

fn int main(String[] args)
{
  @pool()
  {
    io::printn(finishing_order(mem,{3,1,4,2,5},{1,2,4}));
    io::printn(finishing_order(mem,{5,4,3,2,1},{1,3,5}));
    io::printn(finishing_order(mem,{2,4,1,3},{1,2,3,4}));
    io::printn(finishing_order(mem,{4,1,3,2},{3}));
    io::printn(finishing_order(mem,{1,3,2,6,5,4},{1,2,3}));
  };
  return 0;
}

