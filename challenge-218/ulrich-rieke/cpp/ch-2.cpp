#include <vector>
#include <string>
#include <iostream>
#include <algorithm>
#include <cmath>
#include <iterator>

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

std::vector<int> toggle ( const std::vector<int> & aVec ) {
  std::vector<int> toggled ;
  for ( int i : aVec ) {
      if ( i == 0 ) {
    toggled.push_back( 1 ) ;
      }
      else {
    toggled.push_back( 0 ) ;
      }
  }
  return toggled ;
}

std::vector<std::vector<int>> toggle_row( const std::vector<std::vector<int>>
      & input , int row) {
  std::vector<std::vector<int>> toggled ;
  int matrixlen = input.size( ) ;
  for ( int i = 0 ; i < matrixlen ; i++ ) {
      if ( i == row )
    toggled.push_back( toggle( input[ i ] )) ;
      else
    toggled.push_back( input[ i ] ) ;
  }
  return toggled ;
}

std::vector<std::vector<int>> transpose( const std::vector<std::vector<int>>
      & matrix ) {
  int len = matrix.size( ) ;
  int rowlen = matrix[0].size( ) ;
  std::vector<int> current_column ;
  std::vector<std::vector<int>> transposed ;
  for ( int c = 0 ; c < rowlen ; c++ ) {
      for ( int r = 0 ; r < len ; r++ ) {
    current_column.push_back( matrix[ r ][ c ] ) ;
      }
      transposed.push_back( current_column ) ;
      current_column.clear( ) ;
  }
  return transposed ;
}

int to_binary_sum( const std::vector<std::vector<int>> & matrix ) {
  int sum = 0 ;
  int len = matrix[0].size( ) ;
  for ( int r = 0 ; r < matrix.size( ) ; r++ ) {
      for ( int i = 0 ; i  < len ; i++ ) {
    double result = std::pow( 2.0 , static_cast<double>( len - i - 1 ) ) *
        matrix[r][i] ;
    sum += static_cast<int>( result ) ;
      }
  }
  return sum ;
}

int main( ) {
  std::cout << "Please enter some 1 and 0 , separated by blanks, end to end!\n" ;
  std::vector<std::vector<int>> matrix ;
  std::string line ;
  std::getline( std::cin , line ) ;
  while ( line != "end" ) {
      std::vector<std::string> numbers ( split( line , " " ) ) ;
      std::vector<int> row ;
      for ( auto s : numbers ) {
    row.push_back( std::stoi( s ) ) ;
      }
      matrix.push_back( row ) ;
      std::getline( std::cin , line ) ;
  }
  int matrixlen = matrix.size( ) ;
  if ( matrixlen == 1 ) {
      std::vector<int> toggled ( toggle( matrix[ 0 ] ) ) ;
      int sum = 0 ;
      int rowlen = toggled.size( ) ;
      for ( int i = 0 ; i < rowlen ; i++ ) {
    double result = std::pow( 2.0 , static_cast<double>( rowlen
          - i - 1 )) * toggled[ i ] ;
    sum += static_cast<int>( result ) ;
      }
      std::cout << sum << std::endl ;
      return 1 ;
  }
  else {
      std::vector<int> binary_row_sums ; //for the sums of binary rows for
      //the toggling of every row and column
      std::vector<int> all_maxima ; //for the maximal values of all toggled
      //matrices
      int rowlen = matrix[0].size( ) ;
      int startvalue = to_binary_sum( matrix ) ;
      //if all toggling results in a binary sum that is less than startvalue
      //we can stop
      for ( int r = 0 ; r < matrixlen ; r++ ) {
    std::vector<std::vector<int>> toggled ( toggle_row( matrix , r ) ) ;
    binary_row_sums.push_back( to_binary_sum( toggled ) ) ;
      }
      std::vector<std::vector<int>> transposed ( transpose( matrix ) ) ;
      for ( int c = 0 ; c < rowlen ; c++ ) {
    std::vector<std::vector<int>> transpo_toggle ( toggle_row(
          transposed , c ) ) ;
    std::vector<std::vector<int>> toggled( transpose( transpo_toggle )) ;
    binary_row_sums.push_back( to_binary_sum( toggled )) ;
      }
      int maximum = *std::max_element( binary_row_sums.begin( ) ,
        binary_row_sums.end( ) ) ;
      if ( maximum < startvalue ) { //we're done and can stop toggling
    std::cout << maximum << std::endl ;
    return 0 ;
      }
      else {
    all_maxima.push_back( maximum ) ;
    std::vector<std::vector<int>> current_matrix( matrix ) ;
    //the matrix that corresponds to the maximum binary sum is
    //reconstructed as new current matrix. Then we repeat toggling
    //every row and column and find the new maximum. As long as the
    //new maximum is greater than the last maximum, we carry on ;
    //otherwise, we return the second from the end of all_maxima
    while ( all_maxima.size( ) == 1 || all_maxima.back( ) >
          all_maxima[ all_maxima.size( ) - 2] ) {
        auto found = std::find( binary_row_sums.begin( ) ,
          binary_row_sums.end( ) , maximum ) ;
        int max_pos = static_cast<int>( std::distance(
            binary_row_sums.begin( ) , found )) ;
        if ( max_pos < matrixlen ) { //maximum resulted from row toggle
          std::vector<std::vector<int>> temp_matrix( toggle_row(
            current_matrix , max_pos )) ;
          current_matrix = temp_matrix ;
        }
        else { //maximum resulted from column toggle
          transposed = transpose( current_matrix ) ;
          std::vector<std::vector<int>> transpo_toggled =
          toggle_row( transposed , max_pos - matrixlen ) ;
          current_matrix = transpose( transpo_toggled ) ;
        }
        binary_row_sums.clear( ) ; //we start toggling anew, new sums!
        for ( int r = 0 ; r < matrixlen ; r++ ) {
          std::vector<std::vector<int>> toggled =
          toggle_row( current_matrix , r ) ;
          binary_row_sums.push_back( to_binary_sum( toggled )) ;
        }
        transposed = transpose( current_matrix ) ;
        for ( int c = 0 ; c < rowlen ; c++ ) {
          std::vector<std::vector<int>> transpo_toggled =
          toggle_row( transposed , c ) ;
          std::vector<std::vector<int>> toggled (transpose(
            transpo_toggled ))  ;
          binary_row_sums.push_back( to_binary_sum( toggled ) ) ;
        }
        maximum = *std::max_element( binary_row_sums.begin( ) ,
          binary_row_sums.end( ) ) ;
        all_maxima.push_back( maximum ) ;
    }
    std::cout << all_maxima[ all_maxima.size( ) - 2] << std::endl ;
      }
  }
  return 0 ;
}
