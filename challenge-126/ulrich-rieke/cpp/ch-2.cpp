#include <iostream>
#include <string>
#include <vector>
#include <regex>

void countMines( int row , int col , std::vector<std::string> & lines ) {
  int mines = 0 ;
  for ( int currentRow = row - 1 ; currentRow < row + 2 ; currentRow++ ) {
      for ( int currentCol = col - 1 ; currentCol < col + 2 ; currentCol++ ) {
    if ( ( currentRow > -1 && currentRow < 5 ) && ( currentCol > -1 &&
          currentCol < 10 ) ) {
        if ( (*(lines.begin( ) + currentRow)).substr( currentCol , 1 ) == "x" )
          mines++ ;
    }
      }
  }
  (*(lines.begin( ) + row )).replace( col , 1 , std::to_string( mines ) ) ;
}

int main( ) {
  std::vector<std::string> lines ;
  std::string line ;
  std::string linereg( R"(\b(\\*|x){10}\b)") ;
  std::regex reg( linereg ) ;
  std::cout << "Enter 5 strings, 10 characters each, consisting of only * and x!\n" ;
  for ( int i = 0 ; i < 5 ; i++ ) {
      std::getline( std::cin , line ) ;
      while ( ! std::regex_search( line , reg ) ) {
    std::cout << "line in regex loop: " << line << std::endl ;
    std::cout << "line should only consist of 10 characters , either * or x!\n" ;
    std::getline( std::cin , line ) ;
      }
      lines.push_back( line ) ;
  }
  for ( int row = 0 ; row < 5 ; row++ ) {
      for ( int col = 0 ; col < 10 ; col++ ) {
    if ( (*(lines.begin( ) + row)).substr( col , 1 ) == "*" )
        countMines( row , col , lines ) ;
      }
  }
  for ( auto & s : lines ) {
      for ( int i = 0 ; i < 10 ; i++ ) {
    std::cout << s[ i ] << ' ' ;
      }
      std::cout << std::endl ;
  }
  return 0 ;
}
