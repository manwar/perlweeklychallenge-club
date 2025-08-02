#include <iostream>
#include <vector>
#include <iterator>
#include <algorithm>
#include <list>

int main( ) {
   std::cout << "Enter an even number of integers, separated by blanks!\n" ;
   std::cout << "Enter e to end!\n" ;
   std::vector<int> numbers { std::istream_iterator<int>{ std::cin } , 
      std::istream_iterator<int>{} } ;
   std::list<int> numlist { numbers.begin( ) , numbers.end( ) } ;
   std::vector<int> target ;
   while ( numlist.size( ) > 0 ) {
      numlist.sort( ) ;
      int smallest = numlist.front( ) ;
      numlist.pop_front( ) ;
      int secsmallest = numlist.front( ) ;
      numlist.pop_front( ) ;
      target.push_back( secsmallest ) ;
      target.push_back( smallest ) ;
   }
   std::cout << "( " ;
   std::copy( target.begin( ) , target.end( ) ,
	 std::ostream_iterator<int>( std::cout , " " ) ) ;
   std::cout << ")\n" ;
   return 0 ;
}

