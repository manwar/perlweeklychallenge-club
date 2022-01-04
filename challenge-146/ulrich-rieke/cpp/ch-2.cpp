#include <iostream>
#include <string>
#include <algorithm>
#include <utility>

std::pair<int,int> createParent( int dividend , int divisor , int bdividend ,
      int bdivisor ) {
  std::pair<int , int> node ;
  double product = ( (static_cast<double>( dividend ) /
    static_cast<double>( divisor )) *
    ( static_cast<double>( bdividend ) / static_cast<double>(bdivisor))) ;
  int firstMin = std::min( dividend, divisor ) ;
  int secondMin = std::min( bdividend, bdivisor ) ;
  if ( product > 1.0 ) {
      node = std::make_pair( std::max( firstMin , secondMin ) ,
        std::min( firstMin, secondMin ) ) ;
  }
  if ( product < 1.0 ) {
      node = std::make_pair( std::min( firstMin , secondMin ) ,
        std::max( firstMin, secondMin ) ) ;
  }
  if ( product == 1.0 )
      node = std::make_pair( 1 , 1 ) ;
  return node ;
}

std::pair<int, int> createBrother( int dividend , int divisor ) {
  int maximum = std::max( dividend , divisor ) ;
  int minimum = std::min( dividend, divisor ) ;
  if ( maximum == dividend ) {
      return std::make_pair( maximum - minimum , maximum ) ;
  }
  else {
      return std::make_pair( maximum , maximum - minimum ) ;
  }
}

int main( ) {
  std::cout << "Enter a fraction as dividend/divisor!\n" ;
  std::string input ;
  std::cin >> input ;
  std::string::size_type found = input.find( "/" ) ;
  while ( found == std::string::npos ) {
      std::cout << "Please enter a fraction as dividend/divisor!\n" ;
      std::cin >> input ;
      found = input.find( "/" ) ;
  }
  int howmany = static_cast<int>( found ) ;
  int dividend = std::stoi( input.substr( 0 , howmany ) ) ;
  int divisor = std::stoi( input.substr( howmany + 1 ) ) ;
  if ( dividend == 1 && divisor == 1 )
      std::cout << "parent =  and grandparent = " << std::endl ;
  else {
      double fraction = static_cast<double>( dividend ) / static_cast<double>( divisor) ;
      if ( fraction == 0.5 || fraction == 2.0 )
    std::cout << "parent = 1/1 and grandparent =  !" << std::endl ;
      else {
    std::pair<int , int> brother = createBrother( dividend , divisor ) ;
        std::pair<int , int> parent = createParent( dividend, divisor , brother.first ,
          brother.second ) ;
    std::pair<int , int> uncle = createBrother( parent.first , parent.second ) ;
    std::pair<int , int> grandParent = createParent( parent.first , parent.second ,
          uncle.first , uncle.second ) ;
    std::cout << "parent = " << parent.first << '/' << parent.second ;
    std::cout << " and grandparent = " << grandParent.first << '/' <<
        grandParent.second << std::endl ;
      }
  }
  return 0 ;
}
