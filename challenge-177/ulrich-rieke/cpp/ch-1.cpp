#include <iostream>
#include <string>
#include <cstdlib>
#include <vector>

int main( int argc , char * argv[] ) {
  std::vector<std::vector<int>> damm_table
    {{0,  3 , 1 , 7 , 5 , 9 , 8 , 6 , 4 , 2 } ,
    {7 , 0 , 9 , 2 , 1 , 5 , 4 , 8 , 6 , 3 } ,
    {4 , 2 , 0 , 6 , 8 , 7 , 1 , 3 , 5 , 9 } ,
    {1 , 7 , 5 , 0 , 9 , 8 , 3 , 4 , 2 , 6 } ,
    {6 , 1 , 2 , 3 , 0 , 4 , 5 , 9 , 7 , 8 } ,
    {3 , 6 , 7 , 4 , 2 , 0 , 9 , 5 , 8 , 1 } ,
    {5 , 8 , 6 , 9 , 7 , 2 , 0 , 1 , 3 , 4 } ,
    {8 , 9 , 4 , 5 , 3 , 6 , 2 , 0 , 1 , 7 } ,
    {9 , 4 , 3 , 8 , 6 , 1 , 7 , 2 , 0 , 5 } ,
    {2 , 5 , 8 , 1 , 4 , 3 , 6 , 7 , 9 , 0 } } ;
  int n = std::atoi( argv[ 1 ] ) ;
  int interim_digit = 0 ;
  std::string numberstring { argv[1] } ;
  int len = numberstring.length( ) ;
  for ( int i = 0 ; i < len - 1 ; i++ ) {
      interim_digit = *((damm_table.begin( ) + interim_digit)->begin( ) +
    std::stoi( numberstring.substr( i , 1 ))) ;
  }
  if ( interim_digit == n % 10 )
      std::cout << 1 ;
  else
      std::cout << 0 ;
  std::cout << std::endl ;
  return 0 ;
}
