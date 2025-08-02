#include <iostream>

int validate_a_b_string_v1( std::string s ) {
  // this is the boring algorithm that walks through each char in s
  bool first_b = false;
  for ( char sc : s ) {
    // update if we've seen a 'b' yet
    first_b |= ( sc == 'b' );
    if (first_b && sc == 'a') {
      // if we see an 'a' after a 'b' then false
      return false;
    }
  }
  // if we haven't seen any 'b's then first_b is still false
  return first_b;
}

int main(){
  std::string inputs[] = { "aabb", "abab", "aaa", "bbb", "aaaffeoioijlkfjoihslkjhfb" };
  
  for (auto s : inputs ) {
    std::cout << s << " :: "
	      << ( validate_a_b_string_v1( s )  ? "true" : "false" )
	      << "\n";
  }
}
