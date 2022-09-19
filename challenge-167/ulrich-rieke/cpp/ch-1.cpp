#include <iostream>
#include <map>
#include <list>
#include <algorithm>
#include <vector>
#include <cmath>

bool isPrime( int number ) {
  int stop =  std::sqrt( static_cast<double>( number ) ) ;
  for ( int i = 2 ; i <= stop ; ++i )
      if ( number % i == 0 )
        return false ;
  return true ;
}

std::list<int> toList( int n ) {
  std::list<int> digits ;
  while ( n != 0 ) {
      digits.push_back( n % 10 ) ;
      n /= 10 ;
  }
  return digits ;
}
//from list to int
int toInt( const std::list<int> & digits ) {
  int sum = 0 ;
  int multiplier = 1 ;
  for ( auto it = digits.begin( ) ; it != digits.end( ) ; ++it ) {
      sum += multiplier * *it ;
      multiplier *= 10 ;
  }
  return sum ;
}

//create cycled digits per performing the rotations on a list of digits
std::list<int> createCycle( int n ) {
  std::list<int> cycle ;
  std::list<int> digits( toList( n ) ) ;
  cycle.push_back( n ) ;
  digits.push_back( digits.front( ) ) ;
  digits.pop_front( ) ;
  int curnum = toInt( digits ) ;
  while ( curnum != n ) {
      cycle.push_back( curnum ) ;
      digits.push_back( digits.front( ) ) ;
      digits.pop_front( ) ;
      curnum = toInt( digits ) ;
  }
  return cycle ;
}

bool isCircularPrime( int n ) {
  std::list<int> cycle( createCycle( n ) ) ;
  return std::all_of( cycle.begin( ) , cycle.end( ) , isPrime ) ;
}

int main( ) {
  std::vector<int> circularPrimes ;
  int current = 100 ;
  std::map<int , int> primesSoFar ;
  while ( circularPrimes.size( ) != 10 ) {
      std::list<int> currentDigits( toList( current ) ) ;
      if ( std::find( currentDigits.begin( ) , currentDigits.end( ) , 0 )
        == currentDigits.end( ) ) {//we don't want 0's in the number
    if ( isCircularPrime( current )) {
        //the following function call may be regarded as wasteful
        //considering what I did previously ; it's for the sake of
        //clarity
        std::list<int> currentCycle = createCycle( current ) ;
        if ( std::all_of( currentCycle.begin( ) , currentCycle.end( ) ,
        [&primesSoFar]( int i ) { return primesSoFar.find( i ) ==
        primesSoFar.end( ) ; } )) {//all cycled numbers not found
                                        //so far ?
          circularPrimes.push_back( current ) ;
          for ( int i : currentCycle )
          primesSoFar[ i ]++ ;//add them to the numbers found
        }
    }
      }
      current++ ;
  }
  for ( int i : circularPrimes )
      std::cout << i << ' ' ;
  std::cout << std::endl ;
  return 0 ;
}
