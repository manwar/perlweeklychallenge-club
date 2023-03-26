#include <string>
#include <iostream>
#include <vector>
#include <map>
#include <iterator>
#include <algorithm>
#include <utility>
#include <numeric>

std::vector<std::string> split( const std::string & startline ,
      const std::string & sep ) {
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

//merge 2 vectors if the intersection is not empty
std::vector<std::string> merge ( std::vector<std::string> &
      firstArray, std::vector<std::string> & secondArray ) {
  std::vector<std::string> merged ;
  std::sort( firstArray.begin( ) , firstArray.end( ) ) ;
  std::sort( secondArray.begin( ) , secondArray.end( ) ) ;
  std::set_intersection( firstArray.begin( ) ,
    firstArray.end( ) , secondArray.begin( ) , secondArray.end( ) ,
    std::back_inserter( merged ) ) ;
  if ( merged.size( ) > 0 ) {
      std::vector<std::string> intersection ;
      std::set_union( firstArray.begin( ) , firstArray.end( ) ,
        secondArray.begin( ) , secondArray.end( ) ,
        std::back_inserter( intersection )) ;
      return intersection ;
  }
  else
      return merged ;
}

//in what follows we assume that each email address is unique per account
int main( ) {
  //all the addresses with the starting letter as key
  std::map<std::string , std::vector<std::string>> accounts ;
  std::cout << "Enter some email addresses, separated by blanks!\n" ;
  std::cout << "Enter end to end!\n" ;
  std::string line ;
  std::getline( std::cin , line ) ;
  while ( line != "end" ) {
      std::string addresses { line.substr( 2 ) } ;
      std::string letter { line.substr( 0 , 1 ) } ;
      std::vector<std::string> addressSpace ;
      addressSpace.push_back( addresses ) ;
      auto res = accounts.insert( std::make_pair ( line.substr( 0 , 1 ) ,
          addressSpace )) ;
      if ( ! res.second ) {//letter was already inserted
    auto vec = accounts[letter] ;//get associated vector
    vec.push_back( addresses ) ;//and update it
    accounts[ letter ] = vec ;
      }
      std::getline( std::cin , line ) ;
  }
  std::vector<std::pair<std::string , std::vector<std::string>>>
      accountHash ( accounts.begin( ) , accounts.end( ) ) ;
  std::vector<std::string> output ;
  for ( auto it = accountHash.begin( ) ; it != accountHash.end( ) ;
    it++ ) {
      int addressnumbers = (it->second).size( ) ;
      if ( addressnumbers == 1 ) {//only 1 address list per letter, no pairing
    std::vector<std::string> theAddresses ( it->second ) ;
    std::string address_str( std::accumulate( theAddresses.begin( ) ,
          theAddresses.end( ) , std::string( "" ) ,
          []( std::string a ,
            std::string b  ) { return a + std::string(" ") +
          b ; })) ;
    output.push_back( it->first + std::string(" ") + address_str ) ;
      }
      else {//more than one address account for the letter
    std::map<int , int> pairable ;//assume all list to be non-pairable
    for ( int i = 0 ; i < addressnumbers ; i++ )
        pairable[ i ] = 0 ;//to indicate non-pairability, we set the val. to 0
    for ( int i = 0 ; i < addressnumbers - 1 ; i++ ) {
        for ( int j = i + 1 ; j < addressnumbers ; j++ ) {
          std::vector<std::string> firstAddresses(
            split( (it->second)[i] , " " )) ;
          std::vector<std::string> secondAddresses(
            split( (it->second)[j] , " " )) ;
          std::vector<std::string> merged ( merge ( firstAddresses ,
            secondAddresses )) ;
          if ( merged.size( ) > 0 ) {//we found a pair of mergeable accounts
          pairable[ i ] = 1 ;//we set the pairability index to 1
          pairable[ j ] = 1 ;
          std::string outline { std::accumulate( merged.begin( ) ,
            merged.end( ) , std::string("") , []( auto a,
              auto b){
            return a + std::string(" ") + b ; }) } ;
          output.push_back(it->first + std::string(" ") + outline ) ;
          }
        }
    }
    for ( int i = 0 ; i < addressnumbers ; i++ ) {
        if ( pairable[ i ] == 0 ) {
          output.push_back( it->first + std::string(", ")
            + (it->second)[i] ) ;
        }
    }
      }
  }
  std::sort( output.begin( ) , output.end( ) ) ;
  std::cout << "[" ;
  for ( auto s : output ) {
      if ( s != output.back( ) )
    std::cout << "[" << s << "],\n" ;
      else
    std::cout << "[" << s << "]" << std::endl ;
  }
  return 0 ;
}
