#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <utility>
#include <map>
#include <algorithm>

std::vector<std::string> split( const std::string & text , const char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

bool analyze_sentence( const std::string & sentence ) {
   static std::vector<std::pair<int, std::string>> conversions { std::pair( 0 , "zero") ,
      std::pair( 1 , "one" ) , std::pair( 2 , "two" ) , std::pair( 3 , "three" ) ,
      std::pair( 4 , "four" ) , std::pair( 5 , "five" ) , std::pair( 6 , "six" ) ,
      std::pair( 7 , "seven" ) , std::pair( 8 , "eight" ) , std::pair( 9 , "nine" ),
      std::pair( 10 , "ten" ) , std::pair( 11 , "eleven" ) , std::pair( 12 ,
            "twelve" ) , std::pair( 13 , "thirteen" ) , std::pair( 14 , "fourteen" ),
      std::pair( 15 , "fifteen" ) , std::pair( 16 , "sixteen" ) , std::pair( 18 ,
            "eighteen" ) , std::pair( 19 , "nineteen" ) , std::pair( 20 , "twenty") } ;
   static std::map< int , std::string> mappings { conversions.begin( ) , conversions.end( ) } ;
   auto allWords { split( sentence , ' ' ) } ;
   int vowelcount = 0 ;
   int consocount = 0 ;
   std::string vowels { "AEIOUaeiou" } ;
   for ( int i = 0 ; i < allWords[0].length( ) ; i++ ) {
      if ( vowels.find( allWords[0].substr( i , 1 )) != std::string::npos ) {
         vowelcount++ ;
      }
      else {
         consocount++ ;
      }
   }
   return mappings.find( vowelcount)->second == allWords[2] &&
      mappings.find(consocount)->second == allWords[5] ;
}

int main( ) {
   std::cout << std::boolalpha << analyze_sentence( "aa - two vowels and zero consonants" )
      << '\n' ;
   std::cout << std::boolalpha << analyze_sentence("iv - one vowel and one consonant") <<
      '\n' ;
   std::cout << std::boolalpha << analyze_sentence( "hello - three vowels and two consonants")
      << '\n' ;
   std::cout << std::boolalpha << analyze_sentence( "aeiou - five vowels and zero consonants")
      << '\n' ;
   std::cout << std::boolalpha << analyze_sentence( "aei - three vowels and zero consonants")
      << '\n' ;
}
