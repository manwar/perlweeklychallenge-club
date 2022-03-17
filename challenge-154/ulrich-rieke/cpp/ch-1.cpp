#include <iostream>
#include <algorithm>
#include <string>
#include <iterator>

int main( ) {
  std::vector<std::string> firstCombis { "PELR", "PREL", "PERL", "PRLE", "PLER",
      "PLRE", "EPRL", "EPLR", "ERPL", "ERLP", "ELPR", "ELRP", "RPEL", "RPLE",
      "REPL", "RELP", "RLPE", "RLEP", "LPER", "LPRE", "LEPR",
      "LRPE", "LREP" }  ;
  std::vector<std::string> perlcombis ; //combinations of "PERL"
  std::vector<std::string> difference ; //difference of the 2 vectors
  std::string start { "PERL" } ;
  std::sort( start.begin( ) , start.end( ) ) ;
  do {
      perlcombis.push_back( start ) ;
  } while ( std::next_permutation( start.begin( ) , start.end( ) ) ) ;
  std::sort( firstCombis.begin( ) , firstCombis.end( ) ) ;
  std::sort( perlcombis.begin( ) , perlcombis.end( ) ) ;
  std::set_difference( perlcombis.begin( ) , perlcombis.end( ) ,
    firstCombis.begin( ) , firstCombis.end( ) , std::inserter( difference ,
        difference.begin( ) )) ;
  for ( auto & s : difference )
      std::cout << s << " " ;
  std::cout << std::endl ;
  return 0 ;
}
