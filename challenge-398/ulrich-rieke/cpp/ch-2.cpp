#include <iostream>
#include <string> 
#include <sstream>
#include <vector>
#include <map>
#include <algorithm>

std::vector<std::string> split( const std::string & text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) )
      tokens.push_back( word ) ;
   return tokens ;
}

std::vector<int> letter_diffs( const std::string & word ) {
   std::vector<int> diffs ;
   for ( int i = 1 ; i < word.length( ) ; i++ ) {
      diffs.push_back( static_cast<int>( word[i] ) - 
            static_cast<int>( word[i - 1] )) ;
   }
   return diffs ;
}

int main( ) {
   std::cout << "Enter some words with equal lengths greater than 1!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::map<std::string , std::vector<int>> worddiffs ;
   for ( auto w : tokens ) 
      worddiffs[w] = letter_diffs( w ) ;
   std::map<std::vector<int> , int> difffrequencies ;
   for ( auto it : worddiffs )
      difffrequencies[it.second]++ ;
   std::string solution ;
   for ( auto w : tokens ) {
      auto vec = std::find_if( worddiffs.begin( ) , worddiffs.end( ) , 
            [w]( auto const p ) { return p.first == w ; } )->second ;
      auto found = std::find_if( difffrequencies.begin( ) , 
            difffrequencies.end( ) , [vec]( const auto p ) { return
            p.first ==  vec ; }) ;
      if ( found->second == 1 ) {
         solution = w ;
         break ;
      }
   }
   std::cout << solution << '\n' ;
   return 0 ;
}
