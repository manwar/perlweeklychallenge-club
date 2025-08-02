#include <iostream>
#include <vector>
#include <chrono>
#include <string>
#include <string_view>
#include <ranges>
#include <algorithm>

std::chrono::year_month_day stringToDate( const std::string & input ) {
   std::vector<std::string> dateParts ;
   char delimiter = '-' ;
   auto split = input | std::views::split( delimiter ) ;
   for ( const auto& subRange : split ) {
      std::string datePart( &*subRange.begin() ,
	    std::ranges::distance( subRange ) ) ; 
      dateParts.push_back( datePart ) ;
   }
   std::chrono::year y ( std::stoi( dateParts[0] ) ) ;
   std::chrono::month m (static_cast<unsigned>( std::stoi( dateParts[1] )))
      ;
   std::chrono::day d ( static_cast<unsigned>(std::stoi( dateParts[2] ))) ;
   std::chrono::year_month_day date ( y , m , d ) ;
   return date ;
}

int main( ) {
   std::cout << "Enter a start date in the form <year>-<month>-<day>!\n" ;
   std::string start ;
   std::getline( std::cin , start ) ;
   std::cout << "Enter a day offset!\n" ;
   std::string offsetstr ;
   std::getline( std::cin , offsetstr ) ;
   int offset { std::stoi( offsetstr ) } ;
   std::cout << "Enter bank holidays, each day in the format above!\n" ;
   std::cout << "Enter <return> to end!\n" ;
   std::vector<std::string> holidays ;
   std::string free ;
   std::getline( std::cin , free ) ;
   while ( free.length( ) > 0 ) {
      holidays.push_back( free ) ;
      std::getline( std::cin , free )  ;
   }
   std::vector<std::chrono::year_month_day> bank_holidays ;
   for ( auto s : holidays ) {
      bank_holidays.push_back( stringToDate( s )) ;
   }
   std::chrono::time_point theStart { std::chrono::sys_days {
      stringToDate( start ) }} ;
   while ( offset != 0 ) {
      theStart += std::chrono::days{ 1 } ;
      std::chrono::weekday cur_weekday{ theStart } ;
      if ( cur_weekday != std::chrono::Saturday && cur_weekday !=
	    std::chrono::Sunday &&
	    std::find( bank_holidays.begin( ) , bank_holidays.end( ) , 
	       theStart ) == bank_holidays.end( ) ) {
	 offset-- ;
      }
   }
   std::cout << theStart << '\n' ;
   return 0 ;
}
