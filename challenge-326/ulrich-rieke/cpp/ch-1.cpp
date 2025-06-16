#include <vector>
#include <string>
#include <sstream>
#include <iostream>
#include <chrono>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::string word ;
   std::istringstream istr { text } ;
   while ( std::getline( istr , word , delimiter ))
      tokens.push_back( word ) ;
   return tokens ;
}

int number_of_days( std::chrono::sys_days const & first , 
      std::chrono::sys_days const & second ) {
   return (second - first).count( ) ;
}

int main( ) {
   std::cout << "Enter a valid date in the form YYYY-MM-DD!\n" ;
   std::string dateline ;
   std::cin >> dateline ;
   auto parts { split( dateline , '-' ) } ;
   std::chrono::year ye( std::stoi( parts[0] ) ) ;
   std::chrono::month m( std::stoi( parts[1] ) ) ;
   std::chrono::day d( std::stoi( parts[2] ) ) ;
   std::chrono::year_month_day given = ye/ m / d ;
   std::chrono::year_month_day start = ye/ 1 / 1 ;
   std::cout << (number_of_days( start , given ) + 1 ) << '\n' ;
   return 0 ;
}

