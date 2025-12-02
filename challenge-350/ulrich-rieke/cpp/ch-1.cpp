#include <iostream>
#include <set>
#include <string>

int main( ) {
    std::cout << "Enter a string!\n" ;
    std::string word ;
    std::cin >> word ;
    int len = static_cast<int>(word.length( )) ;
    int count = 0 ;
    for ( int i = 0 ; i < len - 2 ; i++ ) {
        std::string part { word.substr( i , 3 ) } ;
        std::set<char> partset { part.begin( ) , part.end( ) } ;
        if (partset.size( ) == 3) 
            count++ ;
    }
    std::cout << count << '\n' ;
    return 0 ;
}
