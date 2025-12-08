#include <vector>
#include <iostream>
#include <sstream>
#include <string>
#include <algorithm>
#include <numeric>
#include <list>

std::vector<int> split( const std::string & text , const char delimiter ) {
    std::vector<int> numbers ;
    std::istringstream istr { text } ;
    std::string word ;
    std::vector<std::string> tokens ;
    while ( std::getline( istr , word , delimiter )) 
        tokens.push_back( word ) ;
    for ( auto s : tokens ) 
        numbers.push_back( std::stoi( s ) ) ;
    return numbers ;
}

int main( ) {
    std::cout << "Enter some numbers separated by blanks!\n" ;
    std::string line ;
    std::getline( std::cin , line ) ;
    auto numbers { split( line , ' ' ) } ;
    int comparison { numbers[0] } ;
    if ( std::all_of( numbers.begin( ) , numbers.end( ) , [comparison]( int i ) {
                return i == comparison ; } ) ) {
        std::cout << 0 << '\n' ;
    }
    else {
        std::list<int> theNumbers { numbers.begin( ) , numbers.end( ) } ;
        int maxi = *std::max_element( theNumbers.begin( ) , theNumbers.end( ) ) ;
        theNumbers.remove( maxi ) ;
        int mini = *std::min_element( numbers.begin( ) , numbers.end( ) ) ;
        theNumbers.remove( mini ) ;
        std::cout << static_cast<double>( std::accumulate( theNumbers.begin( ) ,
                    theNumbers.end( ) , 0 )) / static_cast<int>( theNumbers.size( ) ) <<
            '\n' ;
    }
    return 0 ;
}
