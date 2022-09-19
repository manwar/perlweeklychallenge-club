#include <iostream>
#include <vector>
#include <numeric>
#include <string>
#include <algorithm>

void printMatrix( const std::vector<std::vector<int>> & matrix ) {
  std::vector<int> maxima ;
  for ( const auto & row : matrix ) {
      maxima.push_back( *std::max_element( row.begin( ) , row.end( ) , []( const auto
          numa , const auto numb){ return numa > numb ; })) ;
  }
  int maxWidth = std::to_string(*std::max_element( maxima.begin( ) , maxima.end( )) + 1).
      length( ) ;
  for ( const auto row : matrix ) {
      std::cout << '[' ;
      for ( const auto num : row ) {
    std::cout.width( maxWidth ) ;
    std::cout << num << ' ' ;
      }
      std::cout << "]\n" ;
  }
}

std::vector<int> findRow( const std::vector<int> & firstRow, const std::vector<int>
      & secondRow ) {
  std::vector<int> result ;
  for ( int i : firstRow ) {
      for ( int j : secondRow ) {
    result.push_back( i * j ) ;
      }
  }
  return result ;
}

std::vector<std::vector<int>> findBlock( const std::vector<int> & aRow ,
      const std::vector<std::vector<int>> & aBlock ) {
  std::vector<std::vector<int>> dataBlock ;
  for ( const auto & blockRow : aBlock )
      dataBlock.push_back( findRow( aRow , blockRow ) ) ;
  return dataBlock ;
}

std::vector<std::vector<int>> kronecker ( const std::vector<std::vector<int>> &
      firstMatrix , const std::vector<std::vector<int>> & secondMatrix ) {
  std::vector<std::vector<int>> kronProduct ;
  for ( const auto & row : firstMatrix ) {
      std::vector<std::vector<int>> partialBlock =  findBlock( row, secondMatrix ) ;
      for ( const auto & row : partialBlock )
    kronProduct.push_back( row ) ;
  }
  return kronProduct ;
}

std::vector<std::vector<int>> enterMatrix( ) {
  std::vector<std::vector<int>> aMatrix ;
  std::vector<int> row ;
  std::cout << "Please enter natural numbers , end to end a row, ready to end matr.\n" ;
  std::string number ;
  std::getline( std::cin , number ) ;
  while ( number != "ready" ) {
      if ( number != "end" ) {
    row.push_back( std::stoi( number ) ) ;
      }
      else {
    aMatrix.push_back( row ) ;
    row.clear( ) ;
      }
      std::getline( std::cin , number ) ;
  }
  int len = aMatrix.begin( )->size( ) ;
  std::cout << len << '\n' ;
  while ( ! std::all_of( aMatrix.begin( ) , aMatrix.end( ) , [len]( auto & row ) {
        return row.size( ) == len ; })) {
      std::cout << "Invalid entry! All rows should contain same quantity of numbers!\n" ;
      aMatrix.clear( ) ;
      row.clear( ) ;
      std::getline( std::cin , number ) ;
      while ( number != "ready" ) {
    while ( number != "end" ) {
        row.push_back( std::stoi( number ) ) ;
        std::getline( std::cin , number ) ;
    }
    aMatrix.push_back( row ) ;
    std::getline( std::cin , number ) ;
      }
  }
  return aMatrix ;
}

int main( ) {
  std::vector<std::vector<int>> firstMatrix = enterMatrix( ) ;
  std::vector<std::vector<int>> secondMatrix = enterMatrix( ) ;
  std::vector<std::vector<int>> kronProduct = kronecker( firstMatrix , secondMatrix ) ;
  printMatrix( kronProduct ) ;
  return 0 ;
}
