#include <iostream>
#include <string>
#include <vector>

std::vector<std::string> parse( const std::string & number ) {
   std::vector<std::string> parts ;
   std::string empty {"" } ;
   auto pointpos = number.find( "." ) ;
   parts.push_back( number.substr( 0 , static_cast<int>( pointpos ))) ;
   auto bracketopen = number.find( "(" ) ;
   if ( bracketopen != std::string::npos ) {
      parts.push_back( number.substr( pointpos + 1 , bracketopen - pointpos - 1 )) ;
      parts.push_back( number.substr( bracketopen + 1 , number.length() - 
               static_cast<int>( bracketopen ) - 2 )) ;
   }
   else {
      parts.push_back( empty ) ;
      parts.push_back( empty ) ;
   }
   return parts ;
}

bool areSame( const std::string & firstrat , const std::string & secondrat ) {
   auto firstparts { parse( firstrat ) } ;
   auto secondparts { parse( secondrat ) } ;
   bool result = false ;
   if ( secondparts[1].length( ) == 0 && secondparts[2].length( ) == 0 ) {
      if ( (firstparts[1].find_first_not_of( "9" ) == std::string::npos || 
            firstparts[1].length( ) == 0 ) && firstparts[2].find_first_not_of( "9" )
            == std::string::npos ) {
         result = (std::stoi( secondparts[0] ) == std::stoi( firstparts[0] ) + 1) ;
      }
   }
   else {
      std::string firstexpanded , secondexpanded , pt  {"."} ;
      firstexpanded += ( firstparts[0] + "." + firstparts[1] ) ;
      secondexpanded += ( secondparts[0] + "."  + secondparts[1] ) ;
      if ( firstparts[2].length( ) != 3 ) {
         for ( int i = 0 ; i < 4 ; i++ ) {
            firstexpanded += firstparts[2] ;
         }
      }
      else {
         for ( int i = 0 ; i < 3 ; i++ ) {
            firstexpanded += firstparts[2] ;
         }
      }
      if ( secondparts[2].length( ) != 3 ) {
         for ( int i = 0 ; i < 4 ; i++ ) {
            secondexpanded += secondparts[2] ;
         }
      }
      else {
         for ( int i = 0 ; i < 3 ; i++ ) {
            secondexpanded += secondparts[2] ;
         }
      }
      result =  (firstexpanded.substr( 0 , secondexpanded.length( )) == 
            secondexpanded ) || (secondexpanded.substr( 0 , firstexpanded.length( )) 
            == firstexpanded ) ;
   }
   return result ;
}

int main( ) {
   std::cout << "Enter a rational number!\n" ;
   std::string rat1 , rat2 ;
   std::cin >> rat1 ;
   std::cout << "Enter another rational number!\n" ;
   std::cin >> rat2 ;
   std::cout << std::boolalpha << areSame( rat1 , rat2 ) << '\n' ;
   return 0 ;
}
