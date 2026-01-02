#include <string>
#include <vector>
#include <iostream>
#include <sstream>
#include <algorithm>
#include <utility>
#include <numeric>
#include <iterator>

std::vector<std::string> split( const std::string & text , const char 
        delimiter ) {
    std::vector<std::string> tokens ;
    std::istringstream istr { text } ;
    std::string word ;
    while ( std::getline( istr , word , delimiter ) )
        tokens.push_back( word ) ;
    return tokens ;
}

int main( ) {
    std::cout << "Enter some integers separated by blanks!\n" ;
    std::string line ;
    std::getline( std::cin , line ) ;
    auto tokens { split( line , ' ' ) } ;
    std::vector<int> numbers ;
    for ( auto s : tokens ) 
        numbers.push_back( std::stoi( s ) ) ;
    std::sort( numbers.begin( ) , numbers.end( ) ) ;
    std::vector<std::pair<int , int>> neighbours ;
    int len = numbers.size( ) ;
    for ( int i = 0 ; i < len - 1 ; i++ ) {
        for ( int j = i + 1 ; j < len ; j++ ) {
            neighbours.push_back( std::make_pair( numbers[i] , 
                        numbers[j] ) ) ;
        }
    }
    std::adjacent_difference( numbers.begin( ) , numbers.end( ) , 
            numbers.begin( )) ;
    int mindiff = *std::min_element( numbers.begin( ) + 1 , numbers.end( ) ) ;
    std::vector<std::pair<int , int>> result ;
    for ( const auto p : neighbours ) {
        if ( p.second - p.first == mindiff )
            result.push_back( p ) ;
    }
    for ( const auto p : result ) {
        std::cout << '[' << p.first << ',' << p.second << "] " ;
    }
    std::cout << '\n' ;
    return 0 ;
}
