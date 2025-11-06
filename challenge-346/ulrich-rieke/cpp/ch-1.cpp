#include <vector>
#include <iostream>
#include <algorithm>
#include <iterator>
#include <numeric>
#include <string>

int findSuitableLength( int start , const std::string & parens ) {
   int len = static_cast<int>(parens.length( ) ) ;
   std::vector<int> countBalances ;
   int balance = 1 ;
   countBalances.push_back( balance ) ;
   start++ ;
   while ( start < len ) {
      if ( parens.substr( start , 1 ) == "(" ) {
	 balance++ ;
      }
      else {
	 balance-- ;
	 if ( balance < 0 ) {
	    break ;
	 }
      }
      countBalances.push_back( balance ) ;
      start++ ;
   }
   int last = countBalances.back( ) ;
   if ( last == 0 ) 
      return  static_cast<int>( countBalances.size( ) ) ;
   else {
      auto howmany = std::count( countBalances.begin( ) , 
	    countBalances.end( ) , 0 ) ;
      if ( howmany == 0 ) {
	 return 0 ;
      }
      else {
	 if ( howmany == 1 ) {
	    auto found = std::find( countBalances.begin( ) , 
		  countBalances.end( ) , 0 ) ;
	    return static_cast<int>( std::distance( countBalances.begin( ) , 
		     found )) + 1 ;
	 }
	 else {
	    auto myStart = std::prev( countBalances.end( ) ) ;
	    while ( *myStart != 0 ) {
	       --myStart ;
	    }
	    return static_cast<int>( std::distance( countBalances.begin( ) , 
		     myStart )) + 1;
	 }
      }
   }
}

int main( ) {
   std::cout << "Enter a string consisting of parentheses only!\n" ;
   std::string parens ;
   std::cin >> parens ;
   auto found = std::find( parens.begin( ) , parens.end( ) , '(' ) ;
   std::vector<int> lengths ;
   while ( found != parens.end( ) ) {
      int l = findSuitableLength( static_cast<int>( std::distance( 
		  parens.begin() , found )) , parens )  ;
      lengths.push_back( l ) ;
      found++ ;
      if ( found != parens.end( ) ) {
	 found = std::find( found , parens.end( ) , '(' ) ;
      }
   }
   std::cout << *std::max_element( lengths.begin( ) , lengths.end( ) ) 
      << '\n' ;
}



