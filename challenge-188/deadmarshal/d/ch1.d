import std.stdio:writeln;

int divisible_pairs(int[] arr, int k)
{
  int count = 0;
  for(int i = 0; i < arr.length; ++i)
    for(int j = i+1; j < arr.length; ++j)
      if((arr[i] + arr[j]) % k == 0) count++;
  return count;
}

void main()
{
  writeln(divisible_pairs([4,5,1,6], 2));
  writeln(divisible_pairs([1,2,3,4], 2));
  writeln(divisible_pairs([1,3,4,5], 3));
  writeln(divisible_pairs([5,1,2,3], 4));
  writeln(divisible_pairs([7,2,4,2], 4));
}
