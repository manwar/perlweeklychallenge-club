#include <iostream>
#include <vector>
#include <cstdlib>
#include <algorithm>
#include <iterator>

int main( ) {
  std::cout << "Please enter four integers denoting the lower left and upper right point" ;
  std::cout << "\nof the first rectangle!\n" ;
  int num = 0 ;
  std::vector<int> rectangle1 ;
  for ( int i = 0 ; i < 4 ; i++ ) {
      std::cin >> num ;
      rectangle1.push_back( num ) ;
  }
  std::vector<int> rectangle2 ;
  std::cout << "and now enter four integers for the second rectangle!\n" ;
  num = 0 ;
  for ( int i = 0 ; i < 4 ; i++ ) {
      std::cin >> num ;
      rectangle2.push_back( num ) ;
  }
  int firstArea = (*(rectangle1.begin( ) + 2) - *(rectangle1.begin( ))) *
      (*(rectangle1.begin( ) + 3) - *(rectangle1.begin( ) + 1 )) ;
  int secondArea = (*(rectangle2.begin( ) + 2) - *(rectangle2.begin( ))) *
    (*(rectangle2.begin( ) + 3) - *(rectangle2.begin( ) + 1 )) ;
  std::vector<int> first_xes ;
  std::vector<int> second_xes ;
  std::vector<int> first_ys ;
  std::vector<int> second_ys ;
  for ( int i = rectangle1[0] ; i < rectangle1[2] + 1 ; i++ )
      first_xes.push_back( i ) ;
  for ( int i = rectangle1[1] ; i < rectangle1[3] + 1 ; i++ )
      first_ys.push_back( i ) ;
  for ( int i = rectangle2[0] ; i < rectangle2[2] + 1 ; i++ )
    second_xes.push_back( i ) ;
  for ( int i = rectangle2[1] ; i < rectangle2[3] + 1 ; i++ )
    second_ys.push_back( i ) ;
  std::vector<int> commonX ;
  std::set_intersection( first_xes.begin( ) , first_xes.end( ) , second_xes.begin( ) ,
    second_xes.end( ) , std::inserter( commonX ,commonX.begin( )))  ;
  std::vector<int> commonY ;
  std::set_intersection( first_ys.begin( ) , first_ys.end( ) , second_ys.begin( ) ,
    second_ys.end( ) , std::inserter( commonY , commonY.begin( ))) ;
  int commonArea = (*std::max_element( commonX.begin( ) , commonX.end( )) -
    *std::min_element( commonX.begin( ) , commonX.end( ) ) ) *
      (*std::max_element( commonY.begin( ) , commonY.end( ) ) -
      *std::min_element( commonY.begin( ) , commonY.end( )) ) ;
  std::cout << std::endl ;
  std::cout << (firstArea + secondArea - commonArea) << std::endl ;
  return 0 ;
}
