module ch2;

import std::io,std::collections,std::sort;

fn ulong reflect(ulong u)
{
  ulong r = 0;
  while(u != 0)
  {
    r = (r << 1) | (u & 1);
    u >>= 1;
  }
  return r;
}

fn int cmp(int a, int b)
{
  ulong ra = reflect((ulong)a);
  ulong rb = reflect((ulong)b);
  if(ra != rb) return ra < rb ? -1 : 1;
  if(a != b) return a < b ? -1 : 1;
  return 0;
}

fn List{int} binary_reflection(Allocator allocator,int[] xs)
{
  List{int} out;
  out.init(allocator,xs.len);
  foreach(x : xs) out.push(x);
  sort::quicksort(out.array_view(),&cmp);
  return out;
}

fn int main(String[] args)
{
  @pool()
  {
    io::printn(binary_reflection(mem,{3,6,12}));
    io::printn(binary_reflection(mem,{1,2,4,8}));
    io::printn(binary_reflection(mem,{7,8,9,10}));
    io::printn(binary_reflection(mem,{5,9,15,17}));
    io::printn(binary_reflection(mem,{11,13,14,19}));
  };
  return 0;
}

