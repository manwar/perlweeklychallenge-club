#include <string>
#include <iostream>
#include <vector>
#include <utility>

//find the letter differences of a given string
int findDifference( const std::string & st ) {
  std::vector<int> differences ;
  for ( auto it = st.begin( ) ; it != st.end( ) ; it++ ) {
      differences.push_back( static_cast<int>( *it ) - 97 ) ;
  }
  std::vector<int> results ;
  while ( results.size( ) != 1 ) {
      int len = differences.size( ) ;
      for ( int i = 0 ; i < len - 1 ; i++ ) {
    results.push_back( differences[ i + 1 ] - differences[ i ] ) ;
      }
      if ( results.size( ) != 1 ) {
    differences.clear( ) ;
    for ( int i : results ) {
        differences.push_back( i ) ;
    }
    results.clear( ) ;
      }
  }
  return *results.begin( ) ;
}

std::vector<std::string> split( const std::string & startline , const std::string & sep ) {
  std::vector<std::string> separated ;
  std::string::size_type start { 0 } ;
  std::string::size_type pos ;
  do {
      pos = startline.find_first_of( sep , start ) ;
      separated.push_back( startline.substr(start , pos - start )) ;
      start = pos + 1 ;
  } while ( pos != std::string::npos ) ;
  return separated ;
}

int main( ) {
  std::cout << "Please enter some strings of equal length, separated by blanks!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  std::vector<std::string> strings( split( line , " " )) ;
  std::vector<int> differences ;
  for ( const auto & s: strings ) {//there is a difference for every string
      differences.push_back( findDifference( s ) ) ;
  }
  //we create 3 vectors, for differences above 0 , equal to 0 and under 0
  //we pair the up with the index in the number string which comes first
  //in the pairs. This allows us to immediately access "the odd string"
  std::vector<std::pair<int , int>> aboveNils , nils , underNils ;
  int count = 0 ;
  for ( int i : differences ) {
      if ( i < 0 )
    underNils.push_back( std::make_pair( count , i ) ) ;
      if ( i == 0 )
    nils.push_back( std::make_pair( count , i ) ) ;
      if ( i > 0 )
    aboveNils.push_back( std::make_pair( count , i ) ) ;
      count++ ;
  }
  std::string result ;
  //in all subsequent size checks, if there is only one pair in the array
  //the first int in that pair is the index of the odd string
  if ( underNils.size( ) == 1 ) {
      result = strings[(*underNils.begin( )).first] ;
  }
  else {
      if ( nils.size( ) == 1 ) {
    result = strings[(*nils.begin( ) ).first] ;
      }
      else {
    if ( aboveNils.size( ) != 1 ) {
        result = "Cannot find a clearly distinctive string!" ;
    }
    else {
        result = strings[(*aboveNils.begin( ) ).first] ;
    }
      }
  }
  std::cout << result << std::endl ;
  return 0 ;
}
