#include <vector>
#include <iostream>
#include <iterator>
#include <map>

int main( ) {
   std::cout << "Enter some integers, separated by blanks, 'e' to end!\n" ;
   std::vector<int> numbers { std::istream_iterator<int>( std::cin ) , 
      std::istream_iterator<int>( ) } ;
   std::map<int , int> frequencies ;
   for ( int i : numbers ) {
      frequencies[i]++ ;
   }
   int elements = 0 ;//elements with maximum frequency
   int maximum = 0 ;//maximum frequency
   for ( auto p : frequencies ) {
      if ( p.second > maximum ) 
	 maximum = p.second ;
   }
   for ( auto p : frequencies ) {
      if ( p.second == maximum ) 
	 elements++ ;
   }
   //we want the product of maximum frequency and the number of elements that have it
   std::cout << elements * maximum << '\n' ;
   return 0 ;
}


