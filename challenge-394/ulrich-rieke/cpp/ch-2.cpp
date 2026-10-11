#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <algorithm>
#include <iterator>
#include <utility>
#include <numeric>

std::vector<std::string> split( const std::string & text , const char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

bool isVowel( const char c ) {
   std::string vowels { "aeiou" } ;
   return vowels.find( c ) != std::string::npos ;
}

bool isAlternating( const std::string & word ) {
   std::vector<std::pair<int , char>> letterpairs ;
   int number = 0 ;
   for ( char c : word ) {
      letterpairs.push_back( std::make_pair( number , c )) ;
      number++ ;
   }
   char start { word[0] } ;
   if ( isVowel( start ) ) {
      return std::all_of( letterpairs.begin( ) , letterpairs.end( ) , [] ( const 
               auto p ) { if (p.first % 2 == 0) 
                  return isVowel( p.second ) ;
                  else 
                    return ! isVowel( p.second ) ;
                     } ) ;
                 }
   else {
      return std::all_of( letterpairs.begin( ) , letterpairs.end( ) ,  [] ( const
               auto p ) {
             if ( p.first % 2 == 0 ) 
               return ! isVowel( p.second ) ;
             else 
              return isVowel( p.second ) ;
              } ) ;
   }
}

std::vector<std::string> allSubstrings( const std::string & word ) {
   std::vector<std::string> substrings ;
   int len { static_cast<int>( word.length( ) ) } ;
   for ( int start = 0 ; start < len ; start++ ) {
      for ( int howmany = 1 ; howmany < len - start + 1 ; howmany++ ) {
         substrings.push_back( word.substr( start , howmany ) ) ;
      }
   }
   return substrings ;
}

int main( ) {
   std::cout << "Enter some strings with English alphabetic characters only!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   auto first_strings { allSubstrings( tokens[0] ) } ;
   auto second_strings { allSubstrings( tokens[1] ) } ;
   auto third_strings { allSubstrings( tokens[2] ) } ;
   std::sort( first_strings.begin( ) , first_strings.end( ) ) ;
   std::sort( second_strings.begin( ) , second_strings.end( ) ) ;
   std::sort( third_strings.begin( ) , third_strings.end( ) ) ;
   std::vector<std::vector<std::string>> allVectors { first_strings , 
      second_strings , third_strings } ;
   auto find_common = []( std::vector<std::string> a, 
         std::vector<std::string> b ) {
      std::vector<std::string> myCommon ;
      std::set_intersection( a.begin( ) , a.end( ) , b.begin( ) , 
            b.end( ) , std::back_inserter( myCommon ) ) ;
      return myCommon ;
   } ;
   std::vector<std::string> common = std::accumulate( allVectors.begin( ) , 
         allVectors.end( ) , allVectors[0] , find_common ) ;
   if ( common.size( ) > 0 ) {
      auto end = std::remove_if( common.begin( ) , common.end( ) , [] ( const auto 
               s ) { return ! isAlternating( s ) ; } ) ;
      std::sort( common.begin( ) , end , []( const auto a , const auto b) {
            return a.length( ) > b.length( ) ; }) ;
      std::vector<std::string> solution ;
      std::string startstring { common[0] } ;
      std::copy_if( common.begin( ) , end , std::back_inserter( 
               solution ) , [startstring]( const auto s) { return s.length( ) == 
            startstring.length( ) ; } ) ;
      std::cout << "( ";
      for ( auto s : solution ) {
         std::cout << s << ' ' ;
      }
      std::cout << ")\n" ;
   }
   else {
      std::cout << "()\n" ;
   }
   return 0 ;
}
