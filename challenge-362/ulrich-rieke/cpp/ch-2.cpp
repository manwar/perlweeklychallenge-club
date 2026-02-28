#include <string>
#include <vector>
#include <iostream>
#include <utility>
#include <map>
#include <sstream>
#include <algorithm>
#include <cstdlib>
#include <iterator>

std::vector<std::string> split( const std::string & text , const char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while (std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

std::string findNumberString( const int number , const std::map<int , std::string> 
      & mappings ) {
   std::string numberstring { std::to_string( number ) } ;
   int len = static_cast<int>( numberstring.length( ) ) ;
   std::string converted ;
   if ( len == 1 ) {
      converted += mappings.find( number )->second  ;
   }
   if ( len == 2 ) {
      if ( number % 10 == 0 ) {
         converted += mappings.find( number )->second ;
      }
      else {
         converted += mappings.find(number / 10)->second + "-" +
            mappings.find(number % 10)->second ;
      }
   }
   if ( len == 3 ) {
      if ( number % 100 == 0 ) {
         converted += mappings.find( number / 100 )->second + " hundred" ;
      }
      else {
         converted += mappings.find( number / 100 )->second + " hundred and " +
           findNumberString( number % 100 , mappings ) ;
      }
   }
   if ( len > 3 && len < 7 ) {
      if ( number % 1000 == 0 ) {
         converted += mappings.find( number / 1000 )->second + " thousand" ;
      }
      else {
         converted += mappings.find( number / 1000)->second  + " thousand " 
            + findNumberString( number % 1000 , mappings ) ;
      }
   }
   if ( len > 6 && len < 10 ) {
      if ( number % 1000000 == 0 ) {
         converted += mappings.find( number / 1000000 )->second + " million" ;
      }
      else {
         converted += mappings.find( number / 1000000)->second + " million " +
            findNumberString( number % 1000000, mappings ) ;
      }
   }
   if (len > 9 && len < 13 ) {
      if ( number % 1000000000 == 0 ) {
         converted += mappings.find( number / 1000000000)->second + " billion" ;
      }
      else {
         converted += mappings.find( number / 1000000000)->second + " billion "
            + findNumberString( number % 1000000000 , mappings) ;
      }
   }
   if ( len > 12 ) {
      converted = "workup stops here!" ;
   }
   return converted ;
}

std::string finalCompose( const int number , const std::map<int , std::string> &
      mappings ) {
   std::string converted ;
   if ( number < 0 ) {
      converted += "minus " ;
   }
   converted += findNumberString( abs( number ) , mappings) ;
   return converted ;
}

int main( ) {
   std::vector<std::pair<int, std::string>> conversions { std::pair( 0 , "zero") , 
      std::pair( 1 , "one" ) , std::pair( 2 , "two" ) , std::pair( 3 , "three" ) , 
      std::pair( 4 , "four" ) , std::pair( 5 , "five" ) , std::pair( 6 , "six" ) , 
      std::pair( 7 , "seven" ) , std::pair( 8 , "eight" ) , std::pair( 9 , "nine" ),
      std::pair( 10 , "ten" ) , std::pair( 11 , "eleven" ) , std::pair( 12 , 
            "twelve" ) , std::pair( 13 , "thirteen" ) , std::pair( 14 , "fourteen" ),
      std::pair( 15 , "fifteen" ) , std::pair( 16 , "sixteen" ) , std::pair( 18 , 
            "eighteen" ) , std::pair( 19 , "nineteen" ) , std::pair( 20 , "twenty") ,
      std::pair( 30 , "thirty" ) , std::pair( 40 , "forty" ) , std::pair( 50 , 
            "fifty" ) , std::pair( 60 , "sixty" ) , std::pair( 70 , "seventy" ) , 
      std::pair( 80 , "eighty" ) , std::pair( 90 , "ninety" ) } ;
   std::map<int , std::string> mappings ( conversions.begin( ) , conversions.end( ) ) ;
   std::cout << "Enter some integers separated by whitespace!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::sort( numbers.begin( ) , numbers.end( ) , [mappings]( const int a , const int
            b) { return finalCompose( a , mappings ) < finalCompose( b , mappings ) ;
         } ) ;
   std::copy( numbers.begin( ) , numbers.end( ) ,
         std::ostream_iterator<int>( std::cout , " " )) ; 
   std::cout << '\n' ;
   return 0 ;
}
