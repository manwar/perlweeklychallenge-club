#include <string>
#include <iostream>
#include <sstream>
#include <vector>
#include <map>
#include <algorithm>

std::vector<std::string> split( const std::string & text , const char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

bool can_be_transformed( const std::vector<std::string> & first_line , 
      const std::vector<std::string> & second_line , const std::map<std::string , 
       std::vector<std::string>> & similarities ) {
   if (first_line.size( ) != second_line.size( )) {
      return false ;
   }
   else {
      int l = static_cast<int>( first_line.size( ) ) ;
      std::vector<int> selected ;
      for ( int i = 0 ; i < l ; i++ ) {
         if ( first_line[i] != second_line[i] ) {
            selected.push_back( i ) ;
         }
      }
      if ( selected.size( ) == 0 ) {
         return true ;
      }
      else {
         for ( int i = 0 ; i < selected.size( ) ; i++ ) {
            auto comp1 = first_line[i] ;
            auto comp2 = second_line[i] ;
            auto found = std::find_if( similarities.begin( ) , similarities.end( ) ,
                  [comp1 , comp2]( const auto & p ) { return p.first == comp1 && 
                  std::find( p.second.begin( ) , p.second.end( ) , comp2 ) != 
                  p.second.end( ) ; } ) ;
            if ( found == similarities.end( ) ) {
               return false ;
            }
         }
         return true ;
      }
   }
}


int main( ) {
   std::cout << "Enter some words separated by blanks as first line!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto first_line { split( line , ' ' ) } ;
   std::cout << "Enter some words separated by blanks as second line!\n" ;
   line.clear( ) ;
   std::getline( std::cin , line ) ;
   auto second_line { split( line, ' ' ) } ;
   std::cout << "Enter a similarity map by putting in words separated by blanks!\n" ;
   std::cout << "Enter <newline> to end!\n" ;
   std::map<std::string , std::vector<std::string>> similarities ;
   std::getline( std::cin , line ) ;
   while ( line.length( ) > 0 ) {
      auto tokens { split( line , ' ' ) } ;
      std::vector<std::string> rest ( tokens.begin( ) + 1 , tokens.end( ) ) ;
      for ( auto el : rest ) 
         similarities[tokens[0]].push_back( el ) ;
      std::getline( std::cin , line ) ;
   }
   std::cout << std::boolalpha << ( can_be_transformed( first_line, second_line , 
            similarities ) || can_be_transformed( second_line, first_line , 
               similarities )) << '\n' ;
   return 0 ;
}
