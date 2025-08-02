#include <iostream>
#include <algorithm>
#include <vector>
#include <iterator>
#include <string>
#include <utility>

std::vector<std::string> split( const std::string & startline ,
      const std::string & sep ) {
   std::vector<std::string> separated ;
   std::string::size_type start { 0 } ;
   std::string::size_type pos ;
   do {
      pos = startline.find_first_of( sep , start ) ;
      separated.push_back( startline.substr(start , pos - start )) ;
      start = pos + 1 ;
   } while ( pos != std::string::npos ) ;
   return separated ;
}

//given a certain minute, find the next bus departures, sorted by time of
//departure. Every entry contains the number of the busline and its departure
std::vector<std::pair<int , int>> findNextDepartures( int minute , const 
      std::vector<std::vector<int>> & schedule ) {
   int len = schedule.size( ) ;
   std::vector<std::pair<int , int>> departures ;
   for ( int i = 0 ; i < len ; i++ ) {
      int depart = schedule[i][1] ;
      while ( depart < minute ) {
	 depart += schedule[i][0] ;
      }
      departures.push_back( std::make_pair( i , depart )) ;
   }
   std::sort( departures.begin( ) , departures.end( ) , []( const auto & p1 , 
	    const auto & p2 ) { return p1.second < p2.second ; } ) ;
   return departures ;
}
//find the arrival times of the buses in the order of their start 
std::vector<int> findArrivals( const std::vector<std::vector<int>> & schedule ,
      const std::vector<std::pair<int , int>> & departures ) {
   std::vector<int> arrivals ;
   for ( auto it = departures.begin( ) ; it != departures.end( ) ; ++it ) {
      int arri = it->second + schedule[it->first][2] ;
      arrivals.push_back( arri ) ;
   }
   return arrivals ;
}
//at a given minute , should I let a bus pass ? yes, if the second bus arrives
//strictly sooner, provided 2 buses don't leave at the same time and don't 
//arrive at the same time
bool let_pass_one( int minute , const std::vector<std::vector<int>> & schedule ) {
   std::vector<std::pair<int , int>> next_departures = findNextDepartures(
	 minute , schedule ) ;
   std::vector<int> arrivals = findArrivals( schedule , next_departures ) ;
   if ( (next_departures[0].second != next_departures[1].second) && (arrivals[0] 
	    > arrivals[1] ) ) 
      return true ;
   else 
      return false ;
}

int main( ) {
   std::cout << "Please enter some bus schedules ( 3 numbers per line ) !\n" ;
   std::cout << "Enter <return> to end!\n" ;
   std::string line ;
   std::vector<std::string> allLines ;
   std::getline( std::cin , line ) ;
   while ( line.length( ) > 0  ) {
      allLines.push_back( line ) ;
      std::getline( std::cin , line ) ;
   }
   std::vector<std::vector<int>> schedule ;
   for ( auto & l : allLines ) {
      std::vector<std::string> aLine { split( l , " " ) } ;
      std::vector<int> numbers ;
      for ( auto & w : aLine ) 
	 numbers.push_back( std::stoi( w ) ) ;
      schedule.push_back( numbers ) ;
   }
   std::vector<int> result ;
   for ( int i = 0 ; i < 60 ; i++ ) {
      if ( let_pass_one( i , schedule ) ) 
	 result.push_back( i ) ;
   }
   std::cout << "[ " ;
   std::copy( result.begin( ) , result.end( ) , std::ostream_iterator<int>(
	    std::cout , " " ) ) ;
   std::cout << "]\n" ;
   return 0 ;
}
