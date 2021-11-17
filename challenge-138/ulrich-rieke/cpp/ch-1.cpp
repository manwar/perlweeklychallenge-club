#include <iostream>
#include <cstdlib>
#include <chrono>
#include <array>
#include <algorithm>

//the number of weekdays in a year depends on the weekday of New Year. Every year
//has 52 full weeks, with 52 * 5 weekdays. In a non-leap year, the 31 Dec has the
//same weekday as New Year. If this is a weekday it adds a 261st weekday. In leap
//years, 30 Dec has the same weekday, so that we may have to add 0 , 1 or even
//2 weekdays to the minimum number of 52 * 5 = 260 weekdays, depending on the
//weekday of New Year

int main( int argc , char * argv[ ] ) {
  int year = std::atoi( argv[ 1 ] ) ;
  int weekdays = 0 ;
  auto newYear = std::chrono::year( year ) / std::chrono::month( 1 ) /
      std::chrono::day( 1 ) ;
  auto startWeekday = std::chrono::year_month_weekday( newYear ) ;
  auto newYearWeekday = startWeekday.weekday( ) ;
  if ( ! (newYear.year().is_leap( )) ) {
      if ( newYearWeekday == std::chrono::Saturday || newYearWeekday ==
        std::chrono::Sunday )
    weekdays = 52 * 5 ;
      else
    weekdays = 52 * 5 + 1 ;
  }
  else {
      std::array<std::chrono::weekday , 4> startDays { std::chrono::Monday ,
        std::chrono::Tuesday , std::chrono::Wednesday ,
              std::chrono::Thursday } ;
      if ( newYearWeekday == std::chrono::Saturday ) {
    weekdays = 52 * 5 ;
      }
      if ( newYearWeekday == std::chrono::Friday || newYearWeekday ==
        std::chrono::Sunday )
    weekdays = 52 * 5 + 1 ;
      if ( std::any_of( startDays.begin( ) , startDays.end( ) ,
          [newYearWeekday]( auto d ) { return d == newYearWeekday ;} ))
    weekdays = 52 * 5 + 2 ;
  }
  std::cout << weekdays << std::endl ;
  return 0 ;
}
