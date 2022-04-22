#include <iostream>
#include <map>
#include <string>

int main( ) {
  std::map<int , std::string> numberwords ;
  numberwords[1] = "one" ;
  numberwords[2] = "two" ;
  numberwords[3] = "three" ;
  numberwords[4] = "four" ;
  numberwords[5] = "five" ;
  numberwords[6] = "six" ;
  numberwords[7] = "seven" ;
  numberwords[8] = "eight" ;
  numberwords[9] = "nine" ;
  std::cout << "Enter a number between 1 included and 9 included!\n" ;
  int n ;
  std::cin >> n ;
  while ( n < 1 || n > 9 ) {
      std::cout << "number should be between 1 and 9 , both sides included!\n" ;
      std::cin >> n ;
  }
  std::string numberstring { numberwords[n] } ;
  if ( n == 4 ) {
      std::cout << numberwords[4] << " is four, four is magic.\n" ;
  }
  else {
      numberstring = numberwords[n] ;
      while ( numberstring != "four" ) {
    std::cout << numberstring << " is " ;
    numberstring = numberwords[ static_cast<int>( numberstring.length( ) )] ;
    std::cout << numberstring << ", " ;
      }
      std::cout << "four is magic.\n" ;
  }
  return 0 ;
}
