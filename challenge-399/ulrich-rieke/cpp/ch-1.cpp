#include <iostream>
#include <vector>
#include <sstream>
#include <map>
#include <string>
#include <algorithm>
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

std::map<char , int> findFrequencies( const std::string & word ) {
   std::map<char , int> letterFrequencies ;
   for ( char c : word ) {
      letterFrequencies[c]++ ;
   }
   return letterFrequencies ;
}

std::vector<std::string> allSubstrings( const std::string & word , int k ) {
   std::vector<std::string> substrings ;
   int l { static_cast<int>( word.length( ) ) } ;
   for ( int start = 0 ; start < l - k ; start++ ) {
      for ( int howmany = k ;  howmany < l - start + 1 ; howmany++ ) {
         substrings.push_back( word.substr( start , howmany ) ) ;
      }
   }
   return substrings ;
}

std::pair<int, int> analyzeFrequencies( const std::map<char , int>
      & frequencies ) { 
   std::vector<int> vals ;
   for ( auto p : frequencies ) 
      vals.push_back( p.second ) ;
   int maxfrequency { *std::max_element( vals.begin( ) , vals.end( ) ) } ;
   int resttotal = 0 ;
   for ( auto p : frequencies ) {
      if ( p.second != maxfrequency ) {
         resttotal += p.second ;
      }
   }
   std::pair<int , int> result { std::make_pair( maxfrequency , resttotal ) } ;
   return result ;
}

int main( ) {
   std::cout << "Enter a word with capital letters and a positive number!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::string word { tokens[0] } ;
   int k { std::stoi( tokens[1] ) } ;
   auto wordfreq { findFrequencies( word ) } ;
   int l { static_cast<int>( word.length( ) ) } ;
   if ( wordfreq.size( ) == 1 ) {
      std::cout << l << '\n' ;
   }
   else {
      if ( wordfreq.size( ) == l ) {
         std::cout << (k + 1 ) << '\n' ;
      }
      else {
         auto allSubs { allSubstrings( word , k ) } ;
         std::vector<std::map<char , int>> allSubstringFreqs ;
         for ( auto s : allSubs ) {
            allSubstringFreqs.push_back( findFrequencies( s ) ) ;
         }
         std::vector<std::pair<int , int>> analyzedFreqs ;
         for ( auto p : allSubstringFreqs ) {
            analyzedFreqs.push_back( analyzeFrequencies( p ) ) ;
         }
         auto last = std::remove_if( analyzedFreqs.begin( ) , 
               analyzedFreqs.end( ) , [k] ( const auto p ) { return p.second 
               != k ; } ) ;
         std::sort( analyzedFreqs.begin( ) , last , []( const auto p1 , 
                  const auto p2 ) { return p1.first + p1.second > ( p2.first +
                     p2.second ) ; } ) ;
         std::cout << analyzedFreqs.begin( )->first +
            analyzedFreqs.begin( )->second << '\n' ;
      }
   }
   return 0 ;
}
