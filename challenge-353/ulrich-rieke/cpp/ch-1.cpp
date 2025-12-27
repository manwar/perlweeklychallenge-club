#include <iostream>
#include <string>
#include <sstream>
#include <string>
#include <vector>
#include <algorithm>

std::vector<std::string> split( const std::string & text , const char
        delimiter ) {
    std::vector<std::string> tokens ;
    std::istringstream istr { text } ;
    std::string word ;
    while ( std::getline( istr , word , delimiter ))
        tokens.push_back( word ) ;
    return tokens ;
}

int main( ) {
    std::cout << "Enter some strings , enter <return> to end!\n" ;
    std::string line ;
    std::vector<int> sizes ;
    std::getline( std::cin , line ) ;
    while ( line.length( ) > 0 ) {
        auto tokens { split( line , ' ' ) } ;
        sizes.push_back( tokens.size( ) ) ;
        std::getline( std::cin , line ) ;
    }
    std::cout << *std::max_element( sizes.begin( ) , sizes.end( ) ) << 
        '\n' ;
    return 0 ;
}
