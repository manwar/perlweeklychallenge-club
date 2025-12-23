#include <string>
#include <iostream>
#include <sstream>
#include <algorithm>
#include <vector>

std::vector<std::string> split( const std::string & text , const char delimiter ) {
    std::vector<std::string> tokens ;
    std::istringstream istr { text } ;
    std::string word ;
    while ( std::getline( istr , word , delimiter ) ) 
        tokens.push_back( word ) ;
    return tokens ;
}

int main( ) {
    std::cout << "Enter some strings separated by whitespace!\n" ;
    std::string line ;
    std::getline( std::cin , line ) ;
    auto tokens { split( line , ' ' ) } ;
    std::vector<std::string> result ;
    for ( auto it = tokens.begin( ) ; it != tokens.end( ) ; ++it ) {
        std::string compared { *it } ;
        auto found =  std::find_if( tokens.begin( ) , tokens.end( ) ,
                [compared]( const auto s) { return s != compared 
                && s.find( compared ) != std::string::npos ; } ) ;
        if ( found != tokens.end( ) ) {
            result.push_back( *it ) ;
        }
    }
    auto last = std::unique( result.begin( ) , result.end( ) ) ;
    std::cout << "( " ;
    for ( auto it = result.begin( ) ; it != last ; ++it ) {
        std::cout << *it << ' ' ;
    }
    std::cout << ")\n" ;
    return 0 ;
}
