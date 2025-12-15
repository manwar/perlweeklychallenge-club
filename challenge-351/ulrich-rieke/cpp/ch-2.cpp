#include <iostream>
#include <sstream>
#include <string>
#include <numeric>
#include <vector>
#include <algorithm>

std::vector<double> split( const std::string & text , const char delimiter ) {
    std::vector<double> numbers ;
    std::istringstream istr { text } ;
    std::vector<std::string> tokens ;
    std::string word ;
    while ( std::getline( istr , word , delimiter ) ) 
        tokens.push_back( word ) ;
    for ( auto s : tokens )
        numbers.push_back( std::stod( s ) ) ;
    return numbers ;
}

int main( ) {
    std::cout << "Enter some numbers separated by blanks!\n" ;
    std::string line ;
    std::getline( std::cin , line ) ;
    auto numbers { split( line , ' ' ) } ;
    std::sort( numbers.begin( ) , numbers.end( ) ) ;
    std::adjacent_difference( numbers.begin( ) , numbers.end( ) ,
            numbers.begin( ) ) ;
    double comparison { *(numbers.begin( ) + 1) } ;
    std::cout << std::boolalpha << std::all_of( numbers.begin( ) + 1 , 
            numbers.end( ) , [comparison] ( auto n ) { return n == comparison ;
            } ) << '\n' ;
    return 0 ;
}


