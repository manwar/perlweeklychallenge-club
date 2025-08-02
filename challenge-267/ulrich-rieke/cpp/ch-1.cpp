#include <iostream>
#include <iterator>
#include <vector>
#include <numeric>

int main( ) {
   std::cout << "Enter some integers, separated by blanks!" ;
   std::cout << " Enter e to end entry!\n" ;
   std::vector<int> numbers { std::istream_iterator<int>{ std::cin } , 
      std::istream_iterator<int>{} } ;
   int prod = std::accumulate( numbers.begin( ) , numbers.end( ) , 1 , 
	 std::multiplies<int>( ) ) ;
   int result = 0 ;
   if ( prod < 0 ) 
      result = -1 ;
   if ( prod == 0 ) 
      result = 0 ;
   if ( prod > 0 )
      result = 1 ;
   std::cout << result << '\n' ;
   return 0 ;
}
