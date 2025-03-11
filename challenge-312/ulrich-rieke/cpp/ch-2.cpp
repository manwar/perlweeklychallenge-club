#include <iostream>
#include <map>
#include <string>
#include <set>
#include <vector> 

int main( ) {
   std::cout << "Enter a string with color R , G , B and subsequent numbers!\n " ;
   std::string line ;
   std::cin >> line ;
   std::map<std::string , std::string> boxes ;
   int pos = 0 ;
   while ( pos < line.length( ) - 1 ) {
      const auto [it , success] = boxes.insert( {line.substr( pos + 1 , 1 ) , 
	    line.substr( pos , 1 ) } ) ;
      if ( ! success ) {
	 it->second += line.substr( pos , 1 ) ;
      }
      pos += 2 ;
   }
   int total = 0 ;
   for ( auto it = boxes.begin( ) ; it != boxes.end( ) ; it++ ) {
      std::set<char> letterset { (it->second).begin( ) , (it->second).end( ) } ;
      if ( letterset.size( ) == 3 ) 
	 total++ ;
   }
   std::cout << total << '\n' ;
   return 0 ;
}
