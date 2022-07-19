#include <vector>
#include <iostream>
#include <algorithm>
#include <list>
#include <iterator>

std::vector<std::vector<int>> permuteVector( std::vector<int> & current ) {
  std::vector<std::vector<int>> permuted ;
  std::sort( current.begin( ) , current.end( ) ) ;
  permuted.push_back( current ) ;
  while ( std::next_permutation( current.begin( ) , current.end( ) ))
      permuted.push_back( current ) ;
  return permuted ;
}

int permutation2rank( const std::vector<int> & startVector ) {
  std::vector<int> currentVector( startVector ) ;
  std::vector<std::vector<int>> permuted( permuteVector( currentVector ) ) ;
  auto found = std::find( permuted.begin( ) , permuted.end( ) ,
    startVector ) ;
  return static_cast<int>( std::distance( permuted.begin( ) , found )) ;
}

std::vector<int> rank2permutation( std::vector<int> & current , int rank ) {
  rank = abs( rank ) ;
  std::vector<std::vector<int>> permutations( permuteVector( current )) ;
  if ( rank > permutations.size( ) - 1 ) {
      std::cout << "There is no " << rank << "th rank of the permutations!\n" ;
      std::vector<int> empty ;
      return empty ;
  }
  else {
      return permutations[ rank ] ;
  }
}

void printVector( const std::vector<int> & array ) {
  for ( int v : array ) {
      std::cout << v ;
      if ( v != array.back( ) )
    std::cout << ", " ;
  }
}

int main( ) {
  std::list<int> numbers ;
  std::cout << "Please enter positive integers uniquely ," ;
  std::cout << "negative numbers to end!\n" ;
  int num ;
  std::cin >> num ;
  while ( num > -1 ) {
      numbers.push_back( num ) ;
      std::cin >> num ;
  }
  numbers.unique( ) ;
  std::vector<int> sequence ( numbers.begin( ) , numbers.end( ) ) ;
  int n = permutation2rank( sequence ) ;
  std::cout << "permutation2rank([" ;
  printVector( sequence ) ;
  std::cout << "]) = " << n << std::endl ;
  std::cout << "Please enter a rank number for the permutations!\n" ;
  int rank ;
  std::cin >> rank ;
  std::vector<int> rankedSequence ( rank2permutation( sequence , rank )) ;
  if ( rankedSequence.size( ) > 0 ) {
      std::cout << "rank2permutation([" ;
      printVector( sequence ) ;
      std::cout << "], " << rank << ") = [" ;
      printVector( rankedSequence ) ;
      std::cout << "]\n" ;
  }
  return 0 ;
}
