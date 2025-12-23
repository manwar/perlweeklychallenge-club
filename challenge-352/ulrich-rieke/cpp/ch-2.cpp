#include <iostream>
#include <string>
#include <vector>
#include <sstream>

std::vector<std::string> split( const std::string & text , const char delimiter ) {
    std::vector<std::string> tokens ;
    std::istringstream istr { text } ;
    std::string word ;
    while ( std::getline( istr , word , delimiter ) ) 
        tokens.push_back( word ) ;
    return tokens ;
}

int main( ) {
    std::cout << "Enter some 0 or 1 separated by blanks!\n" ;
    std::string line ;
    std::getline( std::cin , line ) ;
    auto tokens { split( line , ' ' ) } ;
    std::vector<int> numbers ;
    for ( auto s : tokens ) 
        numbers.push_back( std::stoi( s ) ) ;
    std::vector<bool> result ;
    int pos = 0 ;
    while ( numbers[pos] == 0 ) {
        result.push_back( true ) ;
        pos++ ;
    }
    int len = static_cast<int>( numbers.size( ) ) ;
    std::string numberstring ;
    for ( int i = pos ; i < len ; i++ ) {
        numberstring += std::to_string( numbers[i] ) ;
        int number = std::stoi( numberstring , nullptr , 2 ) ;
        result.push_back( number % 5 == 0 ) ;
    }
    std::cout << '(' ;
    for ( bool value : result ) {
        std::cout << std::boolalpha << value << ' ' ;
    }
    std::cout << ")\n" ;
    return 0 ;
}


