#include <string>
#include <vector>
#include <iostream>

std::vector<int> convert( std::string & numberstring ) {
  std::vector<int> numbers ;
  for ( int i = 0 ; i < numberstring.size( ) ; i++ ) {
      if ( numberstring.substr( i , 1 ) != "-" ) {
    numbers.push_back( std::stoi( numberstring.substr( i, 1) ) ) ;
      }
  }
  return numbers ;
}

int main( ) {
  std::cout << "Please enter an ISBN string with only 12 digits!\n" ;
  std::string isbn ;
  std::cin >> isbn ;
  std::string converted ( isbn ) ;
  std::vector<int> numbers { convert( converted ) } ;
  while ( numbers.size( ) != 12 ) {
      std::cout << "Enter an ISBN with only 12 digits, for exercise purposes!\n" ;
      std::cin >> isbn ;
      converted = isbn ;
      numbers = convert( converted ) ;
  }
  std::cout << std::endl ;
  std::vector<int> multipliers ;
  for ( int i = 0 ; i < 6 ; i++ ) {
      multipliers.push_back( 1 ) ;
      multipliers.push_back( 3 ) ;
  }
  int sum = 0 ;
  for ( int i = 0 ; i < 12 ; i++ ) {
      sum += *(numbers.begin( ) + i ) * *(multipliers.begin( ) + i) ;
  }
  int check = 10 - ( sum % 10 ) ;
  if ( check == 10 )
      check == 0 ;
  std::cout << "The ISBN is " << isbn << std::to_string( check ) << " !\n" ;
  return 0 ;
}
