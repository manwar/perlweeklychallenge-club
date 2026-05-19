#include <iostream>
#include <string>
#include <sstream>
#include <vector>

std::vector<std::string> split( const std::string & text , const char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) )
      tokens.push_back( word ) ;
   return tokens ;
}

std::string convert( const std::vector<int> & numbers ) {
   std::string result ;
   int len = numbers.size( ) ;
   if ( len == 1 ) {
      result += ("(" + std::to_string( numbers[0] ) + ")" ) ;
   }
   else {
      result += "(" ;
      for ( int i = 0 ; i < len - 1 ; i++ ) {
         result += (std::to_string( numbers[i] ) + ",") ;
      }
      result += (std::to_string( numbers[ len - 1] ) + ")") ;
   }
   return result ;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto w : tokens ) 
      numbers.push_back( std::stoi( w ) ) ;
   int num ;
   std::cout << "Enter a positive integer!\n" ;
   std::cin >> num ;
   int len = numbers.size( ) ;
   int total = len / num ;
   int remainder = len % num ;
   if ( total == 0 ) {
      std::cout << -1 << '\n' ;
   }
   else {
      std::string solution ; // for the final output
      if ( remainder != 0 ) {
         int pos = 0 ;
         while ( pos != remainder * ( total + 1 ) ) {
            std::vector<int> subarray ;
            for ( int i = 0 ; i < total + 1 ; i++ ) {
               subarray.push_back( numbers[pos + i] ) ;
            }
            solution += convert( subarray ) ;
            pos += total + 1 ;
         }
         pos = remainder * ( total + 1) ;
         while ( pos != len ) {
            std::vector<int> subarray ;
            for ( int i = 0 ; i < total ; i++ ) {
               subarray.push_back( numbers[pos + i] ) ;
            }
            solution += convert( subarray ) ;
            pos += total ;
         }
      }
      else {
         int pos = 0 ;
         while ( pos != len ) {
            std::vector<int> subarray ;
            for ( int i = 0 ; i < total ; i++ ) {
               subarray.push_back( numbers[pos + i] ) ;
            }
            solution += convert( subarray ) ;
            pos += total ;
         }
      }
      std::cout << "( " ;
      for ( auto w : solution ) {
         std::cout << w << ' ' ;
      }
      std::cout << ")\n" ;
   }
   return 0 ;
}
