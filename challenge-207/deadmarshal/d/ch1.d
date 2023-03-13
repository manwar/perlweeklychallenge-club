import std.stdio:writeln,write;
import std.uni:toLower;
import std.algorithm:map,all,canFind;
import std.array:array;

bool all_match(ref string s1, ref string s2)
{
  foreach(ref c;s1) if(!canFind(s2,c)) return false;
  return true;
}

void keyboard_word(ref string[] words)
{
  string[] qwerty = ["qwertyuiop","asdfghjkl","zxcvbnm"];
  words = words.map!(toLower).array;
  foreach(ref q;qwerty)
    foreach(ref w;words) if(all_match(w,q)) write(w,' ');
  writeln;
}

void main()
{
  string[] words1 = ["Hello","Alaska","Dad","Peace"];
  string[] words2 = ["OMG","Bye"];
  keyboard_word(words1);
  keyboard_word(words2);
}

