#include <vector>
#include <iostream>
#include <regex>
#include <utility>
#include <string>
#include <array>
#include <algorithm>

int main( ) {
   std::cout << "Enter some integers between 0 and 2 in brackets, separated by ,!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::string for_number ( "\\d" ) ;
   std::regex np { for_number } ;
   std::vector<int> numbers ;
   auto end = std::sregex_token_iterator{} ;
   for ( auto it = std::sregex_token_iterator{ std::begin( line ) , 
	 std::end( line ) , np } ; it != end ; ++it ) {
      numbers.push_back( std::stoi( *it ) ) ;
   }
   std::vector<std::pair<int , int>> boardpoints ;
   int len = numbers.size( ) ;
   for ( int i = 0 ; i < len - 1 ; i += 2 ) 
      boardpoints.push_back( std::make_pair( numbers[i] , numbers[i + 1] ) ) ;
   //tictactoe board as an array of characters 
   std::array<char , 3> row ;
   row.fill( '_' ) ;
   std::array<std::array<char , 3> , 3> tictactoe ;
   tictactoe.fill( row ) ;
   for ( int i = 0 ; i < boardpoints.size( ) ; i++ ) {
      int row = boardpoints[i].first ;
      int column = boardpoints[i].second ;
      if ( i % 2 == 0 ) {
	 tictactoe[row][column] = 'A' ;
      }
      else {
	 tictactoe[row][column] = 'B' ;
      }
   }
   //one row with equal characters ?
   auto rit = std::find_if( tictactoe.begin( ) , tictactoe.end( ) , []( const auto & r)
	 { char c = r[0] ; return std::all_of( r.begin( ) , r.end( ) , [c]( auto
		  letter) { return letter == c && letter != '_' ; } ) ;}) ;
   if ( rit != tictactoe.end( ) ) {
      std::cout << (*rit)[0] << '\n' ;
      return 0 ;
   }
   //one column with equal characters ?
   std::vector<char> column ;
   std::vector<std::vector<char>> transposed ;
   for ( int c = 0 ; c < 3 ; c++ ) {
      for ( int r = 0 ; r < 3 ; r++ ) {
	 column.push_back( tictactoe[r][c] ) ;
      }
      transposed.push_back( column ) ;
   }
   auto it = std::find_if( transposed.begin( ) , transposed.end( ) , []( const auto r )
	 { char head = r[0] ; return std::all_of( r.begin( ) , r.end( ) , [head]( auto 
		  letter ) { return letter == head && letter != '_' ; } ) ;}) ;
   if ( it != transposed.end( )) {
      std::cout << (*it)[0] << '\n' ;
      return 0 ;
   }
   //is one diagonal filled with the same characters ?
   if ( tictactoe[0][0] == tictactoe[1][1] && tictactoe[1][1] == tictactoe[2][2] &&
	 tictactoe[1][1] != '_' ) {
      std::cout << tictactoe[0][0] << '\n' ;
      return 0 ;
   }
   //what about the other diagonal ?
   if ( tictactoe[2][0] == tictactoe[1][1] && tictactoe[1][1] == tictactoe[0][2] && 
	 tictactoe[1][1] != '_' ) {
      std::cout << tictactoe[2][0] << '\n' ;
      return 0 ;
   }
   //no decision so far and all fields filled with letters => draw!
   if ( std::all_of( tictactoe.begin( ) , tictactoe.end( ) , []( const auto & r ) {
	    return std::all_of( r.begin( ) , r.end( ) , []( const auto letter ) {
		  return (letter == 'A' || letter == 'B') ; }) ;})) {
      std::cout << "Draw\n" ;
      return 0 ;
   }
   //if we haven't returned up to this point it's pending
   std::cout << "Pending\n" ;
   return 0 ;
}
