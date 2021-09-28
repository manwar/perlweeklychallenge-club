#include <iostream>
#include <string>

int main( ) {
  std::cout << "Enter delimiters!\n" ;
  std::string delimiters ;
  std::getline( std::cin , delimiters ) ;
  std::cout << "Enter search string!\n" ;
  std::string searchstring ;
  std::getline( std::cin, searchstring ) ;
  std::string openings ;
  std::string closings ;
  for ( int i = 0 ; i < delimiters.length( ) ; i++ ) {
      if ( i % 2 == 0 )
    openings.append( delimiters.substr( i , 1 ) ) ;
      else
    closings.append( delimiters.substr( i , 1 ) ) ;
  }
  std::string firstPart ;
  std::string secondPart ;
  for ( int i = 0 ; i < searchstring.length( ) ; i++ ) {
      std::string part { searchstring.substr( i , 1 ) } ;
      if ( openings.find( part ) != std::string::npos ) {
    firstPart.append( part ) ;
      }
      if ( closings.find( part ) != std::string::npos )
    secondPart.append( part ) ;
  }
  std::cout << firstPart << std::endl ;
  std::cout << secondPart << std::endl ;
  return 0 ;
}
