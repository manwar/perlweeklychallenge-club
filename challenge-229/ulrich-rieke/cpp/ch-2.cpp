#include <vector>
#include <string>
#include <algorithm>
#include <iterator>
#include <set>
#include <iostream>

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

void addNumbers( std::string input , std::vector<std::vector<int>> & 
      allNumbers ) {
   std::vector<std::string> numbers ( split ( input , " " ) ) ;
   std::vector<int> nums ;
   for ( auto s : numbers ) 
      nums.push_back( std::stoi( s ) ) ;
   //set operations require the vectors to be sorted!!
   std::sort( nums.begin( ) , nums.end( ) ) ;
   allNumbers.push_back( nums ) ;
}

//create pairwise intersections between the lines of number input
//all these lines must be sorted, because otherwise the result of the
//union and intersection operation may be wrong!
//the sorting is done in the addNumbers function
int main( ) {
   std::cout << "Enter a first line of numbers, separated by blanks!\n" ;
   std::string line ;
   std::vector<std::vector<int>> allVectors ;
   std::getline( std::cin , line ) ;
   addNumbers( line , allVectors ) ;
   std::cout << "second line of numbers!\n" ;
   std::getline( std::cin , line ) ;
   addNumbers( line , allVectors ) ;
   std::cout << "third line of numbers!\n" ;
   std::getline( std::cin , line ) ;
   addNumbers( line, allVectors ) ;
   std::vector<std::vector<int>> intersections ;
   std::vector<int> intersect ;
   auto last = std::set_intersection( allVectors[0].begin( ) , 
	 allVectors[0].end( ) , allVectors[1].begin( ) , allVectors[1].end( ),
	 std::inserter (intersect , intersect.begin( )  ) ) ;
   intersections.push_back( intersect ) ;
   intersect.clear( ) ;
   last = std::set_intersection( allVectors[1].begin( ) , 
	 allVectors[1].end( ) , allVectors[2].begin( ) , allVectors[2].end( ),
	 std::inserter( intersect , intersect.begin( )  ) ) ;
   intersections.push_back( intersect ) ;
   intersect.clear( ) ;
   last = std::set_intersection( allVectors[0].begin( ) , 
	 allVectors[0].end( ) , allVectors[2].begin( ) , allVectors[2].end( ),
	 std::inserter (intersect , intersect.begin( )) ) ;
   intersections.push_back( intersect ) ;
   std::vector<int> result ;
   std::set_union( intersections[0].begin( ) , intersections[0].end( ) , 
	 intersections[1].begin( ) , intersections[1].end( ) ,
	 std::back_inserter( result ) ) ;
   std::set_union( intersections[1].begin( ) , intersections[1].end( ) , 
	 intersections[2].begin( ) , intersections[2].end( ) ,
	 std::back_inserter( result ) ) ;
    std::sort( result.begin( ) , result.end( ) ) ;
    std::set<int> output( result.begin( ) , result.end( ) ) ;
    std::cout << "( " ;
    for ( int i : output ) 
       std::cout << i << ' ' ;
    std::cout << ')' << std::endl ;
    return 0 ;
}
