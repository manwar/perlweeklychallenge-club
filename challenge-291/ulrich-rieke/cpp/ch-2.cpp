#include <iostream>
#include <algorithm>
#include <functional>
#include <numeric>
#include <vector>

int different_hands( ) {
   std::vector<int> dividendfigures( 5 ) , divisorfigures( 5 ) ;
   std::iota( dividendfigures.begin( ) , dividendfigures.end( ) , 48 ) ;
   std::iota( divisorfigures.begin( ) , divisorfigures.end( ) , 1 ) ;
   int dividend = std::accumulate( dividendfigures.begin( ) , 
	 dividendfigures.end( ) , 1 , std::multiplies<int>( ) ) ;
   int divisor = std::accumulate( divisorfigures.begin( ) , 
	 divisorfigures.end( ) , 1 , std::multiplies<int>( ) ) ;
   return dividend / divisor ;
}

int faculty( int number ) {
   int fac = 1 ;
   for ( int i = 1 ; i < number + 1 ; i++ ) {
      fac *= i ;
   }
   return fac ;
}

int combinations( int total , int selected ) {
   int dividend = faculty( total ) ;
   int divisor { faculty( total - selected ) * faculty( selected ) } ;
   return dividend / divisor ;
}

int main( ) {
   int select_hands { different_hands( ) } ;
   int royal_flush { 4 } ;
   int straight_runs { 8 } ; //8 possible ways to create a consecutive downrun
   int straight_flush { 8 * 4 } ;
   int four_of_a_kind { 13 * 12 * 4 } ;
   int full_house = combinations( 4 , 3 ) * 13 * combinations( 4 , 2 ) * 12 ;
   int flush = combinations( 13 , 5 ) * 4 ;
   int straight = 4 * 8 * 4 * 4 * 4 * 4 ;
   int three_of_a_kind = combinations( 4 , 3 ) * 13 * 4 * 12 * 4 * 11 ;
   int two_pair = combinations( 4 , 2 ) * 13 * combinations( 4 , 2 ) * 12 * 4 ;
   int pair = combinations( 4 , 2 ) * 13 * 12 * 11 * 10 ;
   int highcards = select_hands - royal_flush - straight_runs - straight_flush 
    - four_of_a_kind - full_house - flush - straight - three_of_a_kind - two_pair
    - pair ;
   std::cout << "total combinations: " << select_hands << '\n' ;
   std::cout << "royal flush: " << royal_flush << '\n' ;
   std::cout << "straight runs: " << straight_runs << '\n' ;
   std::cout << "straight flush: " << straight_flush << '\n' ;
   std::cout << "four of a kind: " << four_of_a_kind << '\n' ;
   std::cout << "full house: " << full_house << '\n' ;
   std::cout << "flush: " << flush << '\n' ;
   std::cout << "straight: " << straight << '\n' ;
   std::cout << "three of a kind: " << three_of_a_kind << '\n' ;
   std::cout << "two pair: " << two_pair << '\n' ;
   std::cout << "pair: " << pair << '\n' ;
   std::cout << "high cards: " << highcards << '\n' ;
   return 0 ;
}
