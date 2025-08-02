#include <iostream>
#include <regex>
#include <string>


using namespace std;

int find_unbroken_words( const string& line, const string& letters ) {
  string letter_expression = "\\S*[" + letters + "]\\S*";

  regex allwords_re ("\\S+");
  regex badwords_re (letter_expression, regex::icase );

  auto all_match = sregex_iterator(line.begin(), line.end(), allwords_re);
  auto bad_match = sregex_iterator(line.begin(), line.end(), badwords_re);
  auto base = sregex_iterator();

  return std::distance(all_match, base) - std::distance(bad_match, base);
}

struct inputline {
  string s;
  const char* cs;
};

int main() {
  inputline inputs[] = {
    { "Perl Weekly Challenge", "la" },
    { "Perl and Raku", "a" },
    { "Well done Team PWC", "lo" },
    { "The joys of polyglottism", "T" },
    { "The joys o*f polyglottism", "*Tp"}
  };

  for (int i=0; i < 5; i++) {
    auto input = inputs[i];
    auto line = input.s;
    auto broken_chars = input.cs;
    cout << line << ", " << broken_chars << " :: " << find_unbroken_words(line, broken_chars) << "\n";
  }
}
  
