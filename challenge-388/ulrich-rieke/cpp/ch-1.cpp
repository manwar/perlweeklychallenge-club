#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

bool condition( const std::string & word ) {
   int len { static_cast<int>( word.length( ) ) } ;
   for ( int i = 1 ; i < len ; i++ ) {
      std::string current { word.substr( 0 , i ) } ;
      if ( std::count( current.begin( ) , current.end( ) , 'D' ) > 
            std::count( current.begin( ) , current.end( ) , 'U' ) ) {
         return false ;
      }
   }
   return true ;
}

int main( ) {
   std::cout << "Enter a positive integer!\n" ;
   int number ;
   std::cin >> number ;
   if ( number == 0 ) {
      std::cout << "\"\"" << '\n' ;
   }
   else {
      std::string current ;
      for ( int i = 0 ; i < number ; i++ ) {
         current.push_back( 'U' ) ;
         current.push_back( 'D' ) ;
      }
      std::vector<std::string> solution ;
      std::string permuword ;
      std::vector<char> letters ;
      for ( char c : current ) 
         letters.push_back( c ) ;
      do {
         for ( auto c : letters ) {
            permuword.push_back( c ) ;
         }
         if ( condition( permuword ) && std::find( solution.begin( ) , 
                  solution.end( ) , permuword ) == solution.end( ) ) {
            solution.push_back( permuword ) ;
         }
         permuword.clear( ) ;
      } while (std::next_permutation( letters.begin( ) , letters.end( ) )) ; 
      std::sort( solution.begin( ) , solution.end( ) ) ;
      std::cout << "( " ;
      for ( auto s : solution ) 
         std::cout << s << " " ;
      std::cout << ")\n" ;
   }
   return 0 ;
}
