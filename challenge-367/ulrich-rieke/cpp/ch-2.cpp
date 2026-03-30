#include <iostream>
#include <string>
#include <sstream>
#include <vector>

std::vector<std::string> split( const std::string &text , const char
      delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

//determines if the second time is later than the first one
bool isLater( const std::string & firstTime , const std::string & 
      secondTime) {
   auto starttimes { split( firstTime , ':' ) } ;
   auto endtimes { split( secondTime , ':' ) } ;
   if ( starttimes[0] != endtimes[0] ) {
      return endtimes[0] > starttimes[0] ;
   }
   else {
      return endtimes[1] > starttimes[1] ;
   }
}

int main( ) {
   std::cout << "Enter the start and end times of a first event!\n" ;
   std::string firstEvent ;
   std::getline( std::cin , firstEvent ) ;
   std::cout << "Enter the start and end times of a second event!\n" ;
   std::string secondEvent ;
   std::getline( std::cin , secondEvent ) ;
   auto firstEventTimes { split( firstEvent , ' ' ) } ;
   auto secondEventTimes { split( secondEvent , ' ' ) } ;
   bool result = true ;
   if ( firstEventTimes[0] == secondEventTimes[0] ) {
   }
   else {
      result = ! ( isLater( firstEventTimes[1] , secondEventTimes[0] ) ||
            secondEventTimes[0] == firstEventTimes[1] ) ;
   }
   std::cout << std::boolalpha << result << '\n' ;
   return 0 ;
}

