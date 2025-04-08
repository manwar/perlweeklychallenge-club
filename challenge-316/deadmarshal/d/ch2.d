import std.stdio;

bool subsequence(string s1,string s2)
{
  ulong i,j;
  while((i < s1.length) && (j < s2.length))
  {
    if(s1[i] == s2[j]) i++;
    j++;
  }
  return i == s1.length;
}

void main()
{
  writeln(subsequence("uvw","bcudvew"));
  writeln(subsequence("aec","abcde"));
  writeln(subsequence("sip","javascript"));
}

