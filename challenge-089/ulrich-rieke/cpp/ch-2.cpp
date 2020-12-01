#include <iostream>
#include <algorithm>
#include <vector>
#include <map>

int main( ) {
  for ( int a = 1 ; a < 10 ; a++ ) {
      for ( int b = 1 ; b < 10 ; b++ ) {
    for ( int c = 1 ; c < 10 ; c++ ) {
        for ( int d = 1 ; d < 10 ; d++ ) {
          for ( int e = 1 ; e < 10 ; e++ ) {
          for ( int f = 1 ; f < 10 ; f++ ) {
              for ( int g = 1 ; g < 10 ; g++ ) {
              for ( int h = 1 ; h < 10 ; h++ ) {
                  for ( int i = 1 ; i < 10 ; i++ ) {
                  if ( a + b + c == 15 &&
                      d + e + f == 15 &&
                      g + h + i == 15 &&
                      a + d + g == 15 &&
                      b + e + h == 15 &&
                      c + f + i == 15 &&
                      a + e + i == 15 &&
                      c + e + g == 15 ) {
                    std::vector<int> sums { a , b , c , d , e , f ,
                    g , h , i } ;
                    std::map<int, int> numberFrequencies ;
                    for ( int n : sums )
                    numberFrequencies[ n ]++ ;
                    if ( std::all_of( numberFrequencies.begin( ) ,
                      numberFrequencies.end( ), []( const auto p ){
                      return p.second == 1 ; } ) ) {
                    std::cout << "[ " << a << " " << b << " " << c
                      << " ]\n" ;
                          std::cout << "[ " << d << " " << e << " " << f
                      << " ]\n" ;
                                        std::cout << "[ " << g << " " << h << " " << i
                      << " ]\n" ;
                        std::cout << std::endl ;
                    }
                  }
                  }
              }
              }
          }
          }
        }
    }
      }
  }
  return 0 ;
}
