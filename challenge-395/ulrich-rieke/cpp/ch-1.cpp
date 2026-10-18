#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <complex>

std::vector<std::string> split( const std::string & text , const 
      char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

std::complex<double> parseNumber( const std::string & numberstring ) {
   auto pos = numberstring.find( '+' ) ;
   std::string real_part { numberstring.substr( 0 , pos ) } ;
   std::string imag_part { numberstring.substr( pos + 1 ) } ;
   double real = std::stod( real_part ) ;
   double image = 0.0 ;
   if ( imag_part.substr( 0 , 2 ) == "(-" ) {
      image = std::stod( imag_part.substr( 1 , static_cast<int>( 
                  imag_part.length()) - 3 ) ) ;
   }
   else {
      image = std::stod( imag_part.substr( 0 , static_cast<int>(
                  imag_part.length( )) - 1 )) ;
   }
   std::complex<double> com( real , image ) ;
   return com ;
}

int main( ) {
  std::cout << "Enter two complex numbers as strings!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  auto tokens { split( line , ' ' ) } ;
  auto com1 { parseNumber( tokens[0] ) } ;
  auto com2 { parseNumber( tokens[1] ) } ;
  std::complex<double> result = com1 * com2 ;
  std::cout << result.real( ) << '+' ;
  if ( result.imag( ) < 0 ) {
     std::cout << '(' ;
  }
  std::cout << result.imag( ) ;
  if ( result.imag( ) < 0 ) {
     std::cout << ')' ;
  }
  std::cout << "i\n" ;
   return 0 ;
}
