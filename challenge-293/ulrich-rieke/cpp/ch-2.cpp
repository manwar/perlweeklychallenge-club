#include <iostream>
#include <utility>
#include <vector>
#include <sstream>
#include <string>

std::pair<int , int> enterCoordinates( const std::string & text , char 
      delimiter ) {
   std::istringstream istr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return std::make_pair( std::stoi( tokens[0] ) , std::stoi( 
	    tokens[1] ) ) ;
}

double findSlope( const std::pair<int , int> & firstPoint , const 
      std::pair<int , int> & secondPoint ) {
   return  static_cast<double>( secondPoint.second - firstPoint.second)
	  / static_cast<double>( secondPoint.first - firstPoint.first ) ;
}

int main( ) {
   std::vector<std::pair<int , int>> points ;
   for ( int i = 0 ; i < 3 ; i++ ) {
      std::cout << "Enter 2 integer coordinates, separated by blanks!\n" ;
      std::string line ;
      std::getline( std::cin , line ) ;
      auto p {enterCoordinates( line , ' ' ) } ;
      points.push_back( p ) ;
   }
   bool firstCondition = points[0] != points[1] && points[1] != points[2] ;
   bool secondCondition = findSlope( points[0] , points[1] ) != 
      findSlope( points[1] , points[2] ) ;
   std::cout << std::boolalpha << (firstCondition && secondCondition) << 
      '\n' ;
   return 0 ;
}
