#include <string>
#include <vector>
#include <utility>
#include <algorithm>
#include <iostream>

int main( ) {
    std::cout << "Enter a word!\n" ;
    std::string word ;
    std::cin >> word ;
    std::pair<char , int> neighbouring ;
    std::vector<std::pair<char , int>> neighbours ;
    char last_char = word.front( ) ;
    int count = 1 ;
    for ( char c : word.substr( 1 ) ) {
        if ( c == last_char ) {
            count++ ;
        }
        else {
            neighbouring = std::make_pair( last_char , count ) ;
            neighbours.push_back( neighbouring ) ;
            count = 1 ;
            last_char = c ;
        }
    }
    neighbours.push_back( std::make_pair( last_char , count ) ) ;
    std::sort( neighbours.begin( ) , neighbours.end( ) , []( const auto & aPair , 
                const auto & bPair ) { return aPair.second > bPair.second ; } ) ;
    std::cout << neighbours.begin( )->second << '\n' ;
    return 0 ;
}
