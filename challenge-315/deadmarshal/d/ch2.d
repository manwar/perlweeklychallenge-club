import std.stdio;
import std.string;
import std.regex;

string[] find_third(string sentence,string first,string second)
{
  string[] ret;
  string[] words = sentence.split(' ');
  foreach(i;0..words.length-1)
  {
    if((words[i] == first) && (words[i+1] == second))
    {
      words[i+2] = replaceAll(words[i+2],regex(r"\W$"),"");
      ret ~= words[i+2];
    }
  }
  return ret;
}

void main()
{
  writeln(find_third("Perl is a my favourite language but Python" ~
		     " is my favourite too.", "my", "favourite"));
  writeln(find_third("Barbie is a beautiful doll also also a " ~
		     "beautiful princess.", "a", "beautiful"));
  writeln(find_third("we will we will rock you rock you.", "we", "will")); 
}

