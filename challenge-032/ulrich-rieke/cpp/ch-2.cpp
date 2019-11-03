#include <iostream>
#include <string>
#include <vector>
#include <utility>
#include <algorithm>
#include <cmath>
#include <map>
#include <iterator>

using e_type = std::pair<std::string, double> ;
using e_r_type = std::pair<std::string, int> ;

std::map<std::string, double> enterData( ) {
  std::map<std::string, double> theData ;
  std::string item ;
  std::cout << "Enter items( end to end) : " ;
  std::cin >> item ;
  while ( item != "end" ) {
      double quantity = 0.0 ;
      std::cout << "enter quantity : " ;
      std::cin >> quantity ;
      theData[ item ] = quantity ;
      std::cout << "Enter items( end to end) : " ;
      std::cin >> item ;
  }
  return theData ;
}

std::vector<e_r_type> normalizeData( std::map<std::string, double> & dats ) {
  std::map<std::string, double>::iterator result ;
  result = std::max_element( dats.begin( ) , dats.end( ) ,
    []( const e_type & a, const e_type & b ) { return a.second <
    b.second ; } ) ;
  double maximum = result->second ;
  //if the maximum item number is greater than 40, we want to scale the
  //numbers in order to make rendering easier
  double scalefactor = 0.0 ;
  if ( maximum > 40.0 ) {
      scalefactor = 40.0 / maximum ;
  }
  if ( scalefactor != 0.0 ) {
      std::vector<e_r_type> allRounded ;
      for ( auto & el : dats ) {
    el.second *= scalefactor ;
      }
  }
  std::vector<e_r_type> allRounded ;
  for ( auto & el : dats ) {
      allRounded.push_back( std::make_pair( el.first ,
          static_cast<int>( round ( el.second ) ) ) ) ;
  }
  return allRounded ;
}

void generate_bar_graph( std::vector<e_r_type> & myData ) {
  //in order to "pretty print" the items we want to find out the maximum
  //length of an item
  std::string answer ;
  std::vector<e_r_type>::iterator result ;
  result = std::max_element( myData.begin( ) , myData.end( ) ,
    []( const e_r_type & el1, const e_r_type & el2 ) { return
    el1.first.length( ) < el2.first.length( ) ; } ) ;
  int maxlen = (result->first).length( ) ;
  std::cout << "maxlen is " << maxlen << '\n' ;
  std::cout << "You can order the output by item or by quantity!\n" ;
  std::cout << "Do you want to order by item ? (y)es or (n)o ?" ;
  std::cin >> answer ;
  if (answer.substr( 0, 1 ) == "n" ) {//we order by quantity and have to sort
      std::sort( myData.begin( ) , myData.end( ) , []( e_r_type & el1 ,
          e_r_type & el2 ) { return el1.second > el1.second ; } ) ;
  }
  else {//we order by item
      std::sort( myData.begin( ) , myData.end( ) ) ;
  }
  for ( const e_r_type & element : myData ) {
      std::cout << element.first ;
      std::cout.width( maxlen - element.first.length( ) + 1 ) ;
      std::cout << "|" ;
      for ( int i = 0 ; i < element.second ; i++ ) {
    std::cout << '#' ;
      }
      std::cout << std::endl ;
  }
}

int main( ) {
  std::map<std::string, double> theData {enterData( ) } ;
  std::vector<e_r_type> rounded { normalizeData( theData ) } ;
  generate_bar_graph( rounded ) ;
  return 0 ;
}

