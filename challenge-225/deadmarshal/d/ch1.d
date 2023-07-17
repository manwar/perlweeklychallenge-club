import std.stdio:writeln;
import std.uni:isSpace;

size_t max_words(const ref string[] arr)
{
  size_t count = 0,max = 0;
  foreach(ref s; arr)
  {
    foreach(ref c;s) if(isSpace(c)) count++;
    if(max < count) max = count;
    count = 0;
  }
  return max+1;
}

void main()
{
  string[] a1 = ["Perl and Raku belong to the same family.",
		 "I love perl.",
		 "The Perl and Raku Conference."];
  string[] a2 = ["The Weekly Challenge.",
		 "Python is the most popular guest language.",
		 "Team PWC has over 300 members."];
  writeln(max_words(a1));
  writeln(max_words(a2));
}

