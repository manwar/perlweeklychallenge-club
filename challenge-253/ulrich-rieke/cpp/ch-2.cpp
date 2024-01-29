#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>

bool mySorter( const std::pair<int, std::vector<int>> &  , 
      const std::pair<int, std::vector<int>> &  ) ;


int main( ) {
   std::cout << "Enter some lines of 1 and 0, beginning with 1!\n" ;
   std::cout << "Enter a negative number to end line entry!\n" ;
   std::cout << "How many lines do you want to enter?\n" ;
   int lines ;
   std::cin >> lines ;
   std::vector<std::pair<int , std::vector<int>>> matrix ;
   int count = 0 ;
   while ( count < lines ) {
      std::vector<int> numbers ;
      int nextnum ;
      std::cin >> nextnum ;
      while ( nextnum > -1 ) {
	 numbers.push_back( nextnum ) ;
	 std::cin >> nextnum ;
      }
      matrix.push_back( std::make_pair( count , numbers ) ) ;
      count++ ;
   }
   std::sort( matrix.begin( ) , matrix.end( ) , mySorter ) ;
   std::cout << "(" ;
   for ( const auto & p : matrix ) {
      std::cout << p.first << " " ;
   }
   std::cout << ")\n" ;
   return 0 ;
}

bool mySorter( const std::pair<int, std::vector<int>> & someFirst ,
      const std::pair<int, std::vector<int>> & someSecond ) {
   int ones_a = std::count( someFirst.second.begin( ) ,
	 someFirst.second.end( ) , 1 ) ;
   int ones_b = std::count( someSecond.second.begin( ) , 
	 someSecond.second.end( ) , 1 ) ;
   if ( ones_a != ones_b ) {
      return ones_a < ones_b ;
   }
   else {
      return someFirst.first < someSecond.first ;
   }
}
