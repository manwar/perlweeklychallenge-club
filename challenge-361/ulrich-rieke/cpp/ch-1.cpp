#include <iostream>
#include <algorithm>
#include <vector>
#include <iterator>

int fibonacci( int number ) {
   int result = 0 ;
   if ( number == 0 || number == 1 ) 
      result =  number ;
   if ( number > 1 ) 
      result =  fibonacci( number - 2 ) + fibonacci( number - 1 ) ;
   return result ;
}

int main( ) {
   std::cout << "Enter an integer <= 100!\n" ;
   int number ;
   std::cin >> number ;
   std::vector<int> fibonaccis ;
   for ( int i = 0 ; i < 13 ; i++ ) 
      fibonaccis.push_back( fibonacci( i ) ) ;
   std::reverse( fibonaccis.begin( ) , fibonaccis.end( ) ) ;
   std::vector<int> result ;
   while ( number != 0 ) {
      auto found = std::find_if( fibonaccis.begin( ) , fibonaccis.end( ) , 
            [number]( const int i) { return i <= number ; } ) ;
      result.push_back( *found ) ;
      number -= *found ;
   }
   std::copy( result.begin( ) , result.end( ) , std::ostream_iterator<int>( 
            std::cout , " " )) ;
   std::cout << '\n' ;
   return 0 ;
}
      
