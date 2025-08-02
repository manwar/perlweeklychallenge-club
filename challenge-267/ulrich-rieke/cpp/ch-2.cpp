#include <iostream>
#include <string>
#include <vector>
#include <ranges>
#include <string_view>
#include <algorithm> 
#include <map> 

int main( ) {
   std::cout << "Enter a string!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::cout << "Enter 26 character widths, separated by ',' !\n" ;
   std::string widths ;
   std::getline( std::cin, widths ) ;
   std::string characters { "abcdefghijklmnopqrstuvwxyz" } ;
   std::vector<std::string> widthstrings ;
   char delimiter = ',' ;
   auto split = widths | std::views::split( delimiter ) ;
   for ( const auto & subrange : split ) {
      std::string wistring( &*subrange.begin( ) , std::ranges::distance( 
	       subrange ) ) ;
      widthstrings.push_back( wistring ) ;
   }
   std::vector<int> charWidths ;
   for ( auto s : widthstrings ) 
      charWidths.push_back( std::stoi( s ) ) ;
   std::map<std::string , int> letterwidths ;
   for ( int i = 0 ; i < 26 ; i++ ) {
      letterwidths[ characters.substr( i , 1 ) ] = charWidths[ i ] ;
   }
   int sum = 0 ;
   int pixels = 0 ;
   int linenumber = 1 ;
   for ( int i = 0 ; i < line.length( ) ; i++ )  {
      sum += letterwidths.at( line.substr( i , 1 ) ) ;
      if ( sum > 100 ) {
	 linenumber++ ;
	 sum = letterwidths.at( line.substr( i , 1 ) ) ;
      }
      if ( sum == 100 ) {
	 linenumber++ ;
	 sum = 0 ;
      }
   }
   if ( sum == 0 ) 
      linenumber-- ;
   pixels = sum ;
   std::cout << '(' << linenumber << ',' << pixels << ")\n" ;
   return 0 ;
}
