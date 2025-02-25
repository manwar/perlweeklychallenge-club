#include <string>
#include <vector>
#include <sstream>
#include <iostream>
#include <algorithm>
#include <utility>

std::vector<std::string> split( const std::string & text , char delimiter ) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr , word , delimiter ) ) {
      tokens.push_back( word ) ;
   }
   return tokens ;
}

//we zip the 2 vectors which in this case we know to be equally long
std::vector<std::pair<int , int>> zip( const std::vector<int> & firstPartner , 
      const std::vector<int> & secondPartner ) {
   std::vector<std::pair<int , int>> allPairs ;
   int len = firstPartner.size( ) ;
   for ( int i = 0 ; i < len ; i++ ) {
      allPairs.push_back( std::make_pair( firstPartner[i] , secondPartner[i] )) ;
   }
   return allPairs ;
}

//cycle an initial vector and cut off as many elements as necessary to
//achieve a given length
std::vector<int> cycle_take( const std::vector<int> & initial , int len ) {
   std::vector<int> cycled ;
   while ( cycled.size( ) < len ) {
      for ( auto it = initial.begin( ) ; it != initial.end( ) ; it++ ) {
	 cycled.push_back( *it ) ;
      }
   }
   while ( cycled.size( ) > len ) 
      cycled.pop_back( ) ;
   return cycled ;
}

int main( ) {
   std::cout << "Enter some 0 and 1 separated by spaces!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::cout << "Enter a positive integer!\n" ;
   int n ;
   std::cin >> n ;
   std::vector<int> numbers ;
   for ( auto s : tokens ) 
      numbers.push_back( std::stoi( s ) ) ;
   int len = numbers.size( ) ;
   if ( len == 1 ) {
      std::cout << "false" << '\n' ;
   }
   else {
      //if there are at least 2 neighbouring ones it can't be true!
      bool result = false ;
      for ( int i = 0 ; i < len - 1 ; i++ ) {
	 if ( numbers[i] == 1 && numbers[i + 1] == 1 ) {
	    result = true ;
	    break ;
	 }
      }
      if ( result ) {
	 std::cout << "false" << '\n' ;
      }
      else {
	 //if we have at least one isolated 1 in the numbers array we build
	 //an array of alternating 1 and zero
	 //depending on where we find the first 1 our initial array is either
	 //(0 , 1 ) or (1 , 0 ). We then zip this array with the numbers array
	 //that was input and count the number of transversions from 0 to 1 which
	 //has to be greater than or equal than the initial integer entered
	 std::vector<int> comparison , initial_array ;
	 auto pos = std::find( numbers.begin( ) , numbers.end( ) , 1 ) ;
	 if ( pos != numbers.end( ) ) {
	    int step = static_cast<int>( std::distance( numbers.begin( ) , pos ) ) ;
	    if ( step % 2 == 1 ) {
	       initial_array = {0 , 1} ;
	    }
	    else {
	       initial_array = {1 , 0} ;
	    }
	 }
	 else {
	    initial_array = {0 , 1} ;
	 }
	 comparison = cycle_take( initial_array , len ) ;
	 auto zipped { zip( numbers , comparison ) } ;
	 int flipped = 0 ;
	 for ( auto p : zipped ) {
	    if ( p.first == 0 && p.second == 1 ) {
	       flipped++ ;
	    }
	 }
	 std::cout << std::boolalpha << (flipped >= n ) << '\n' ;
      }
   }
   return 0 ;
}
