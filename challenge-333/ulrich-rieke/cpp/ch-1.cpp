#include <string>
#include <vector>
#include <utility>
#include <regex> 
#include <iostream>
#include <algorithm> 
using namespace std::string_literals ;

bool on_straight_line( const std::vector<std::pair<int , int>> & coords ) {
   int first_x = coords[0].first ;
   int first_y = coords[0].second ;
   if ( std::all_of( coords.begin( ) , coords.end( ) , [first_x]( auto p ) {
	    return p.first == first_x ; } ) || std::all_of( coords.begin( ) ,
	       coords.end( ) , [first_y]( auto b ) { return b.second ==
	       first_y ; }))
      return true ;
   else {
      double slope_one = (static_cast<double>(coords[1].second) - 
	    static_cast<double>(coords[0].second )) / (static_cast<double>(
	       coords[1].first) - static_cast<double>(coords[0].first )) ;
      double slope_two = (static_cast<double>(coords[2].second) - 
	    static_cast<double>(coords[1].second )) / (static_cast<double>(
	       coords[2].first) - static_cast<double>(coords[1].first )) ;
      return slope_one == slope_two ;
   }
}

int main( ) {
   std::cout << "Enter 3 coordinates in brackets!\n" ;
   std::string inputline ;
   std::getline( std::cin , inputline ) ;
   auto pattern {R"(\d+)"s} ;
   auto re  = std::regex { pattern } ;
   std::vector<std::pair<int , int>> coordinates ;
   std::vector<std::string> numbers ;
   auto end = std::sregex_token_iterator{} ;
   for ( auto it = std::sregex_token_iterator { std::begin( inputline ) , 
	 std::end( inputline ) , re } ; it != end ; ++it ) {
      numbers.push_back( *it ) ;
   }
   for ( int i = 0 ; i < numbers.size( ) - 1 ; i += 2) {
      coordinates.push_back( std::make_pair( std::stoi( numbers[i] ) , 
	       std::stoi( numbers[i + 1] ) )) ;
   }
   std::cout << std::boolalpha << on_straight_line( coordinates ) << '\n' ;
   return 0 ;
}
