#include <vector>
#include <iostream>
#include <algorithm>

std::vector<std::vector<char>> createNewList(
      std::vector<std::vector<char>> & list ) {
  int minlength = std::min_element( list.begin( ) , list.end( ) ,
    []( auto & listA , auto & listB ) { return listA.size( ) <
    listB.size( ) ; } )->size( ) ;
  std::vector<std::vector<char>> result ;
  std::vector<char> partialResult ;
  for ( int i = 0 ; i < minlength ; i++ ) {
      for ( auto  it = list.begin( ) ; it != list.end( ) ; it++ ) {
    partialResult.push_back( *(it->begin() + i) ) ;
      }
      result.push_back( partialResult ) ;
      partialResult.clear( ) ;
  }
  return result ;
}

int main( ) {
  std::vector<char> array1 {'I', 'L' , 'O',  'V' , 'E' , 'Y' , 'O', 'U' } ;
  std::vector<char> array2 {'2', '4' , '0', '3', '2' , '0' , '1' , '9' } ;
  std::vector<char> array3 {'!' , '?' , 'F', '$' , '%' , '^' , '&' , '*' } ;
  std::vector<std::vector<char>> list ;
  list.push_back( array1 ) ;
  list.push_back( array2 ) ;
  list.push_back( array3 ) ;
  std::vector<std::vector<char>> result = createNewList( list ) ;
  for ( auto & li : result ) {
      for ( auto  it = li.begin( ) ; it != li.end( ) ; it++ ) {
    std::cout << *it << ' ' ;
      }
      std::cout << std::endl ;
  }
  return 0 ;
}
