#include <iostream>
#include <algorithm>
#include <vector>
#include <string>

//find all combinations of 1 and 2 that add up to the given length
std::vector<std::vector<int>> findAllCombinations( int len ) {
  std::vector<std::vector<int>> allCombinations ;
  std::vector<int> currentCombi ;
  std::vector<std::vector<int>> thePermus ;
  for ( int twos = 0 ; twos < len / 2 + 1 ; twos++ ) {
      int ones = len - twos * 2 ;
      for ( int i = 0 ; i < ones ; i++ ) {
    currentCombi.push_back( 1 ) ;
      }
      for ( int i = 0 ; i < twos ; i++ ) {
    currentCombi.push_back( 2 ) ;
      }
      allCombinations.push_back( currentCombi ) ;
      currentCombi.clear( ) ;
  }
  //permute the combinations that contain both 1 and 2
  for ( auto combi : allCombinations ) {
      if ( std::find( combi.begin( ) , combi.end( ) , 1 ) != combi.end( )
        && ( std::find( combi.begin( ) , combi.end( ) , 2 ) !=
          combi.end( ))) {
    std::vector<int> aCombi { combi } ;
    while (std::next_permutation( aCombi.begin( ) , aCombi.end( ) )) {
        thePermus.push_back( aCombi ) ;
    }
      }
  }
  //push the permutations to the existing combinations
  for ( auto combi : thePermus ) {
      allCombinations.push_back( combi ) ;
  }
  return allCombinations ;
}

//take the given number string apart according to the combination of
//1's an 2's
std::vector<int> findNumbers( const std::string & st , const
      std::vector<int> & nums ) {
  std::vector<int> numbers ;
  int pos = 0 ;
  for ( int i : nums ) {
      numbers.push_back( std::stoi( st.substr( pos , i ))) ;
      pos += i ;
  }
  return numbers ;
}

//transform every number into a letter
std::string createWord( const std::vector<int> & numbers ) {
  std::string word ;
  if ( std::any_of( numbers.begin( ) , numbers.end( ) , []( int i ) {
        return i > 26 ; })) {
      return "" ;
  }
  else {
      for ( int n : numbers ) {
    word += static_cast<char>( n + 64 ) ;
      }
      return word ;
  }
}

int main( ) {
  std::cout << "Please enter a string consisting only of digits!\n" ;
  std::string line ;
  std::cin >> line ;
  std::vector<std::string> allWords ;
  std::vector<std::vector<int>> allCombinations ( findAllCombinations(
        line.length( ))) ;
  for ( auto & comb : allCombinations ) {
      std::string word ( createWord( findNumbers( line , comb ))) ;
      if ( word.length( ) > 0 )
    allWords.push_back( word ) ;
  }
  std::sort( allWords.begin( ) , allWords.end( ) ) ;
  for ( const auto & w : allWords ) {
      std::cout << w << ' ' ;
  }
  std::cout << std::endl ;
  return 0 ;
}
