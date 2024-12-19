#include <iostream>
#include <algorithm>
#include <vector>
#include <numeric>

bool condition( const std::vector<int> & permu ) {
   int index = 1 ;
   for ( auto it = permu.begin( ) ; it != permu.end( ) ; it++ ) {
      if ( ! ( *it % index == 0 || index % *it == 0 ) ) { 
	 return false ;
      }
      index++ ;
   }
   return true ;
}

int main( ) {
   std::cout << "Enter a positive integer!\n" ;
   int number ;
   std::cin >> number ;
   std::vector<int> numbers( number ) ;
   std::iota( numbers.begin( ) , numbers.end( ) , 1 ) ;
   int sum = 0 ;
   while (std::next_permutation( numbers.begin( ) , numbers.end( ) ) ) {
      if ( condition( numbers ) ) 
	 sum++ ;
   }
   std::cout << sum + 1 << '\n' ; //the start vector is the first permutation
   //already! 
   return 0 ;
}


