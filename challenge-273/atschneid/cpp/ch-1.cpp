#include <iostream>

struct char_and_string {
  // a struct to hold a char, string for inputs
  char character;
  std::string string;
};

std::ostream& operator<<( std::ostream& os, char_and_string const& cas ){
  // specifies how to pipe our struct into iostream
  return os << "{ char='" << cas.character << "', string=\"" << cas.string << "\" }";
}

int percent_string_char( std::string s, char c ) {
  // this is the boring algorithm that walks through each char in s
  int sum_char = 0;
  int sum_all = 0;
  for (char sc : s ) {
    sum_char += (sc == c);
    sum_all++;
  }
  return std::round( sum_char * 100.0 / sum_all );
}

int main(){
  char_and_string inputs[] = {
    {'p', "c plus plus"},
    {'a', "java"},
    {'e', "perl"},
    {'m', "python"},
    {'k', "analitik"}
  };
  
  for (auto sac : inputs ) {
    std::cout << sac << " :: "
	      << percent_string_char( sac.string, sac.character )
	      << "\n";
  }
}
