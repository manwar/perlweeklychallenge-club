#include <iostream>
#include <map>
#include <string>

bool isIsomorphic( const std::string & myA, const std::string & myB ) {
  if ( myA.length( ) != myB.length( )) {
      return false ;
  }
  else {
      std::map<char, char> mapped_from ;
      std::map<char , int> mapped_to ;
      for ( int i = 0 ; i < myA.length( ) ; i++ ) {
    mapped_from[myA[i]] = myB[i] ;
    mapped_to[myB[i]]++ ;
      }
      return mapped_from.size( ) == mapped_to.size( ) ;
  }
}


int main( int argc, char * argv[] ) {
  if ( argc != 3 ) {
      std::cerr << "Usage <programname> <string1> <string2>\n" ;
      return 1 ;
  }
  else {
      std::string myA( argv[ 1 ] ) ;
      std::string myB( argv[2] ) ;
      if ( isIsomorphic( myA , myB ) )
    std::cout << 1 << std::endl ;
      else
    std::cout << 0 << std::endl ;
      return 0 ;
  }
}
