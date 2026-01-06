#include <string>
#include <iostream>
#include <vector>
#include <sstream>
#include <algorithm>
#include <iterator>
#include <numeric>

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
    for ( const auto & s : tokens ) {
        numbers.push_back( std::stoi( s ) ) ;
    }
    bool result = false ;
    if ( numbers.size( ) < 3 ) // we require at least 3 elements
        result = false ;
    else {
        auto maxpos = std::max_element( numbers.begin( ) , numbers.end( ) ) ;
        //the maximum element can't be at the beginning or the end of array
        //numbers ;
        if ( (maxpos == numbers.begin( )) || (maxpos == std::prev( 
                        numbers.end( ) , 1 ) )) {
                result = false ;
        }
        else {          
            std::vector<int> differences ;
            std::adjacent_difference( numbers.begin( ) , numbers.end( ) ,
                    std::inserter( differences , differences.begin( ) )) ;
            auto dist = std::distance( numbers.begin( ) , maxpos ) ;
            result = ( std::all_of( differences.begin( ) + 1 , 
                        differences.begin( ) + dist + 1 , []( int i ) {
                        return i > 0 ; })) && ( std::all_of(
                            differences.begin( ) + dist + 1 , 
                            differences.end( ) , [](int i) { return 
                            i < 0 ; } )) ;

        }
    }
    std::cout << std::boolalpha << result << '\n' ;
    return 0 ;
}
