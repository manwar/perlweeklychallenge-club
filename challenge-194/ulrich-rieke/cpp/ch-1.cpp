#include <iostream>
#include <string>
#include <vector>
#include <numeric>
#include <algorithm>

int main( int argc, char * argv[] ) {
  if ( argc != 2 ) {
      std::cerr << "Usage: <challenge194> <string>!\n" ;
      return 1 ;
  }
  else {
      std::string searchStr ( argv[1] ) ;
      auto pos = searchStr.find("?" , 0) ;
      int i = static_cast<int>( pos ) ;
      int digit = 10 ;
      std::vector<int> hours( 24 ) ;
      std::iota( hours.begin( ) , hours.end( ) , 0 ) ;
      std::vector<int> minutes( 60 ) ;
      std::iota( minutes.begin( ) , minutes.end( ) , 0 ) ;
      int otherDigit = 0 ;
      switch (i) {
    case 0 : otherDigit = std::stoi( searchStr.substr( i + 1 , 1 ) ) ;
          do {
            digit-- ;
          } while ( std::find( hours.begin( ) , hours.end( ) , digit * 10
              + otherDigit ) == hours.end( ) ) ; break ;
        case 1 : otherDigit = std::stoi( searchStr.substr( i - 1 , 1 )) ;
          do {
            digit-- ;
          } while ( std::find( hours.begin( ) , hours.end( ) , otherDigit
              * 10 + digit ) == hours.end( ) ) ; break ;
    case 3 : otherDigit = std::stoi( searchStr.substr( i + 1 ,    1 )) ;
          do {
            digit-- ;
          } while ( std::find( minutes.begin( ) , minutes.end( ) ,
              digit * 10 + otherDigit ) == minutes.end( ) ) ;
          break ;
    case 4 : otherDigit = std::stoi( searchStr.substr( i - 1 , 1 )) ;
          do {
            digit-- ;
          } while ( std::find( minutes.begin( ) , minutes.end( ) ,
              otherDigit * 10 + digit ) == minutes.end( ) ) ;
          break ;
    default : ;
      }
      std::cout << digit << std::endl ;
      return 0 ;
  }
}
