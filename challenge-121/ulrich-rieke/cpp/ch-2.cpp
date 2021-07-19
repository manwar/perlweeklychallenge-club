#include <vector>
#include <algorithm>
#include <cstdlib>
#include <map>
#include <numeric>
#include <iostream>
#include <ctime>
#include <utility>
#include <iterator>

//for the random number generator
int findNumber( ) {
  return (std::rand( ) % 30 + 1 ) ;
}

std::vector<int> createRandomLine( int howmany ) {
  std::vector<int> line( howmany ) ;
  std::srand( std::time( 0 ) ) ;
  std::generate_n( line.begin( ) , line.size( ) , findNumber ) ;
  return line ;
}

//find a number in a given row of number and collect the columns where
//they were found in a vector ; a number may occur more than once because
//a random generator is at work
std::vector<int> findColumns( const std::vector<int> & line , int num ) {
  std::vector<int> columns ;
  int howmany = std::count( line.begin( ) , line.end( ) , num ) ;
  if ( howmany == 1 ) {
      auto iter = std::find( line.begin( ) , line.end( ) , num ) ;
      int col = static_cast<int>( std::distance( line.begin( ) , iter ) ) ;
      columns.push_back( col ) ;
  }
  if ( howmany > 1 ) {
      for ( int col = 0 ; col < 20 ; col++ ) {
    if ( line[ col ] == num )
        columns.push_back( col ) ;
      }
  }
  return columns ;
}

//for every row in the matrix, we sort the row, look for the columns
//where the sorted numbers occur in the unsorted row and check whether
//the column was already visited. We return the first column that was
//not already visited
int findUnseenColumn( const std::vector<int> & line ,
      const std::map<int , bool> & seenSoFar ) {
  std::vector<int> forSorting( line ) ;
  std::sort( forSorting.begin( ) , forSorting.end( ) ) ;
  std::vector<int> allFoundColumns ;
  for ( int i = 1 ; i < 20 ; i++ ) {
      std::vector<int> foundAt = findColumns( line , forSorting[ i ] ) ;
      for ( int v : foundAt ) {
    allFoundColumns.push_back( v ) ;
      }
  }
  int col = *std::find_if( allFoundColumns.begin( ) ,
    allFoundColumns.end( ) , [&seenSoFar]( int c ) { return
    seenSoFar.find( c ) == seenSoFar.end( ) ; } ) ;
  return col ;
}

int main( ) {
  std::vector<std::vector<int>> matrix ;
  std::map<int,bool> visited ;
  std::vector<int> tour ;// the places that were visited
  int row = 0 ;
  std::vector<int> currentLine ;
  currentLine.push_back( 0 ) ;
  tour.push_back( 0 ) ;
  visited.insert( std::make_pair( row , true )) ;
  while ( matrix.size( ) < 20 ) {
      std::vector<int> randomDistances ;
      if ( row == 0 ) {
    randomDistances =  createRandomLine( 19 ) ;
      }
      if ( row > 0 ) {//we must re-create the first columns from the rows above
    randomDistances = createRandomLine( 20 - row - 1 ) ;
    for ( int col = 0 ; col < row ; col++ )
        currentLine.push_back( matrix[ col ][ row ] ) ;
    currentLine.push_back( 0 ) ;
      }
      for ( int n : randomDistances )
    currentLine.push_back( n ) ;
      row++ ;
      matrix.push_back( currentLine ) ;
      currentLine.clear( ) ;
  }
  std::cout << "The matrix generated is:\n" ;
  for ( int i = 0 ; i < 20 ; i++ ) {
      std::cout << '[' ;
      for ( int c : *(matrix.begin( ) + i) )
    std::cout << c << " " ;
      std::cout << ']' << std::endl ;
  }
  row = 0 ;
  int length = 0 ;//distance covered between the cities
  while ( visited.size( ) < 20 ) {
      currentLine = *(matrix.begin( ) + row ) ;
      int col = findUnseenColumn( currentLine, visited ) ;
      length += currentLine[ col ] ;
      tour.push_back( col ) ;
      row = col ;
      visited.insert( std::make_pair( col , true ) ) ;
  }
  length += currentLine[ 0 ] ; //we return to the start
  tour.push_back( 0 ) ; // same here
  std::cout << "length = " << length << std::endl ;
  std::cout << "tour = (" ;
  for ( int n : tour ) {
      std::cout << n << " " ;
  }
  std::cout << ')' << std::endl ;
  return 0 ;
}
