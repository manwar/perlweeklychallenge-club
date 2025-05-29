#include <vector>
#include <string>
#include <sstream>
#include <utility>
#include <iostream>
#include <numeric>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::string word ;
   std::istringstream istr { text } ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter an income!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   int income { std::stoi( line ) } ;
   std::cout << "Enter some tax brackets separated by blanks!\n";
   std::cout << "Do it like that : [a,b] [c,d] and so on!\n" ;
   std::getline( std::cin , line ) ;
   auto brackets { split( line , ' ' ) } ;
   std::vector<std::pair<int , int>> pairs ;
   for ( auto br : brackets ) {
      auto pair { split( br , ',' ) } ;
      int firstelement = std::stoi( pair[0].substr( 1 ) ) ;
      int len = static_cast<int>( pair[1].length( ) ) ;
      int secondelement = std::stoi( pair[1].substr(0 , len - 1 ) ) ;
      pairs.push_back( std::make_pair( firstelement , secondelement ) ) ;
   }
   std::vector<int> differences ;
   for ( auto p : pairs ) 
      differences.push_back( p.first ) ;
   std::adjacent_difference( differences.begin( ) , differences.end( ) , 
	 differences.begin( ) ) ;
   std::vector<int> taxparts ;
   int len = differences.size( ) ;
   int sum = 0 ;
   int index = 0 ;
   while ( sum < income ) {
      taxparts.push_back( differences[index] ) ;
      sum += differences[index] ;
      index++ ;
   }
   if ( sum > income ) {
      taxparts.back( ) -= (sum - income) ;
   }
   double totaltax = 0.0 ;
   for ( int i = 0 ; i < taxparts.size( ) ; i++ ) {
      totaltax += taxparts[i] * pairs[i].second / 100.0 ;
   }
   std::cout << totaltax << '\n' ;
   return 0 ;
}
