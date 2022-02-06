#include <iostream>
#include <vector>
#include <string>

int main( ) {
  std::string firstnum ;
  std::string secondnum ;
  std::cout << "Enter a number string consisting of digits only!\n" ;
  std::cin >> firstnum ;
  std::cout << "Enter a second number string consisting of digits only!\n" ;
  std::cin >> secondnum ;
  while ( secondnum.length( ) != firstnum.length( ) ) {
      std::cout << "second number string should be as long as the first one!\n" ;
      std::cin >> secondnum ;
  }
  std::vector<std::string> fibonacciWords { firstnum , secondnum } ;
  while ( fibonacciWords.back( ).length( ) < 51 ) {
      fibonacciWords.push_back( fibonacciWords[ fibonacciWords.size( ) - 2 ] +
        fibonacciWords.back( ) ) ;
  }
  std::cout << fibonacciWords.back( ).substr( 50 , 1 ) << std::endl ;
  return 0 ;
}
