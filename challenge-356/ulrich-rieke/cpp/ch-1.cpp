#include <vector>
#include <iostream>
#include <algorithm>

int main( ) {
    std::cout << "Enter a number greater than 3!\n" ;
    int number ;
    std::cin >> number ;
    std::vector<int> kolakoski ;
    int i = 1 ;
    while ( kolakoski.size( ) < number ) {
        if ( kolakoski.size( ) == 0 ) {
            kolakoski.push_back( 1 ) ;
        }
        else {
            bool pushed = false ;
            if ( kolakoski.size( ) < i ) {
                kolakoski.push_back( i ) ;
                pushed = true ;
            }
            if ( i % 2 == 1 ) {
                if ( ! pushed ) {
                    for ( int n = 0 ; n < kolakoski[i - 1] ; n++ ) 
                        kolakoski.push_back( 1 ) ;
                }
                else {
                    kolakoski.push_back( 1 ) ;
                }
            }
            else {
                if ( ! pushed ) {
                    for ( int n = 0 ; n < kolakoski[i - 1] ; n++ ) {
                        kolakoski.push_back( 2 ) ;
                    }
                }
                else {
                    kolakoski.push_back( 2 ) ;
                }
            }
        }
        i++ ;
    }
    if ( kolakoski.size( ) > number ) {
        std::cout << std::count( kolakoski.begin( ) , kolakoski.begin( ) + 
                number , 1 ) ; 
    }
    else {
        std::cout << std::count( kolakoski.begin( ) , kolakoski.end( ) , 1 ) ;
    }
    std::cout << '\n' ;
    return 0 ;
}
