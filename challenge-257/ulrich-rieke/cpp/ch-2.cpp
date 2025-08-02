#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <iterator>
#include <utility>
typedef std::vector<std::vector<int>> matrix ;

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

bool hasLeadingOne( const matrix & numbers ) {
   for ( auto & row : numbers ) {
      auto found = std::find_if( row.begin( ) , row.end( ) , []( int n ) { 
	    return n != 0 ; } ) ;
      if ( found != row.end( ) ) {
	 if (*found != 1) {
	    return false ;
	 }
      }
   }
   return true ;
}

bool zeroesAtBottom( const matrix & numbers ) {
   std::vector<int> zeroIndices ;
   std::vector<int> theRest ;
   int count = 0 ;
   for ( auto & row : numbers ) {
      auto found = std::find_if( row.begin( ) , row.end( ) , []( int n ) {
	    return n != 0 ; } ) ;
      if ( found != row.end( ) ) { //row does not only contain 0
	 theRest.push_back( count ) ;
      }
      else { //row contains only 0
	 zeroIndices.push_back( count ) ;
      }
      count++ ;
   }
   //the maximum row number of all lines not containing 0's only must be 
   //smaller than any of the line numbers of lines containing only 0's
   int maximum = *std::max_element( theRest.begin( ) , theRest.end( ) ) ;
   return std::all_of( zeroIndices.begin( ) , zeroIndices.end( ) , 
	 [maximum]( int n ) { return n > maximum ; } ) ;
}

//are all leading ones staggered from left to right ?
bool staggeredOnes( const matrix & numbers ) {
   std::vector<int> leadingOnes ; //the positions of all leading 1's
   for ( auto & row : numbers ) {
      auto found = std::find_if( row.begin( ) , row.end( ) , []( int n ) {
	    return n != 0 ; } ) ;
      if ( found != row.end( ) ) {
	 if ( *found == 1 ) {
	    leadingOnes.push_back( static_cast<int>(std::distance( row.begin( ),
			found ))) ;
	 }
      }
   }
   int len = leadingOnes.size( ) ;
   if ( len == 0 || len == 1 ) {
      return true ;
   }
   if ( len == 2 ) {
      return leadingOnes[1] > leadingOnes[0] ;
   }
   if ( len > 2 ) {
      for ( int i = 0 ; i < len - 1 ; i++ ) {
	 if ( leadingOnes[ i + 1 ] < leadingOnes[ i ] ) {
	    return false ;
	 }
      }
   }
   return true ;
}

bool allZeroesInLeadingOneColumn( const matrix & numbers ) {
   std::vector<std::pair<int, int>> leadingOnePositions ;
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < len ; i++ ) {
      std::vector<int> row { numbers[ i ] } ;
      auto found = std::find_if( row.begin( ) , row.end( ) , []( int n ) {
	    return n != 0 ; } ) ;
      if ( found != row.end( ) ) {
	 if ( *found == 1 ) {
	    int pos = static_cast<int>(std::distance( row.begin( ) , found ) ) ;
	    leadingOnePositions.push_back( std::make_pair( i , pos ) ) ;
	 }
      }
   }
   for ( auto & p : leadingOnePositions ) {
      for ( int i = 0 ; i < len ; i++ ) {
	 if ( i != p.first ) {
	    if ( numbers[i][p.second] != 0 ) {
	       return false ;
	    }
	 }
      }
   }
   return true ;
}

int main( ) {
   std::cout << "Enter some integers, separated by blanks!\n" ;
   std::cout << "Enter <return> to stop entry!\n" ;
   std::string line ;
   matrix numbers ;
   std::getline( std::cin , line ) ;
   while ( line.length( ) != 0 ) {
      std::vector<std::string> row { split( line , " " ) } ;
      std::vector<int> numberrow ;
      for  ( auto & s : row ) {
	 numberrow.push_back( std::stoi( s ) ) ;
      }
      numbers.push_back( numberrow ) ;
      line.clear( ) ;
      std::getline( std::cin , line ) ;
   }
   if ( hasLeadingOne( numbers ) && zeroesAtBottom( numbers ) && 
      staggeredOnes( numbers ) && allZeroesInLeadingOneColumn( numbers )) {
      std::cout << 1 << '\n' ;
   }
   else {
      std::cout << 0 << '\n' ;
   }
   return 0 ;
}

