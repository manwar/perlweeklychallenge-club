import std.stdio:writeln;
import std.algorithm:all,filter,reduce,uniq,minElement,sort;
import std.array:array;

int most_frequent_even(int[] arr)
{
  if(all!"a & 1"(arr)) return -1;
  int[int] hash;
  foreach(int i; filter!(a => !(a & 1))(arr)) if(!(i & 1)) hash[i]++;
  if(hash.values.length == hash.values.uniq.array.length)
    return hash.keys.minElement;
  return reduce!((a,b) => hash[a] == hash[b] ? a : b)(hash.keys.sort);
}

void main()
{
  int[] a1 = [1,1,2,6,2];
  int[] a2 = [1,3,5,7];
  int[] a3 = [6,4,4,6,1];
  writeln(most_frequent_even(a1));
  writeln(most_frequent_even(a2));
  writeln(most_frequent_even(a3));
}

