#include <vector>
#include <iostream>
#include <iterator>
#include <algorithm>

int main( ) {
  std::vector<int> numbers ;
  std::cout << "Enter an integer , -1 to end!\n" ;
  int n ;
  std::cin >> n ;
  while ( n != -1 ) {
      numbers.push_back( n ) ;
      std::cout << "next integer!\n" ;
      std::cin >> n ;
  }
  std::cout << "Enter a single integer!\n" ;
  std::cin >> n ;
  auto last = std::remove_if( numbers.begin( ) , numbers.end( ) , [n]( const int a )
    {return a <= n ; } ) ;
  std::ostream_iterator<int> output( std::cout , " " ) ;
  std::cout << "( " ;
  std::copy( numbers.begin( ) , last , output ) ;
  std::cout << ')' << std::endl ;
  return 0 ;
}
