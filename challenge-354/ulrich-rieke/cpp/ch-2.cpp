#include <iostream>
#include <string>
#include <vector>
#include <sstream>

std::vector<std::string> split( const std::string & text , const char
        delimiter ) {
    std::vector<std::string> tokens ;
    std::istringstream istr ( text ) ;
    std::string word ;
    while ( std::getline( istr , word , delimiter ) )
        tokens.push_back( word ) ;
    return tokens ;
}

std::vector<int> rotateLeft( std::vector<int> & numbers ) {
    std::vector<int> rotated ;
    rotated.push_back( numbers.back( ) ) ;
    int len = numbers.size( ) ;
    for ( int i = 0 ; i < len - 1 ; i++ ) 
        rotated.push_back( numbers[i] ) ;
    return rotated ;
}

int main( ) {
    std::cout << "Enter m x n integers as a matrix , <return> to end!\n" ;
    std::vector<int> allNumbers ;
    std::string line ;
    std::getline( std::cin , line ) ;
    int columns = 0 ;
    while ( line.length( ) > 0 ) {
        auto tokens { split( line , ' ' ) } ;
        columns = tokens.size( ) ;
        std::vector<int> numbers ;
        for ( auto s : tokens ) {
            numbers.push_back( std::stoi( s ) ) ;
        }
        for ( auto it = numbers.begin( ) ; it != numbers.end( ) ; ++it )
            allNumbers.push_back( *it ) ;
        std::getline( std::cin , line ) ;
    }
    std::cout << "How many shifts do you want ?\n" ;
    int shifts ;
    std::cin >> shifts ;
    for ( int i = 0 ; i < shifts ; i++ ) {
        allNumbers = rotateLeft( allNumbers ) ;
    }
    int rows = allNumbers.size( ) / columns ;
    std::cout << "(\n" ;
    for ( int r = 0 ; r < rows ; r++ ) { 
        std::cout << " [ " ;
        for ( int i = r * columns ; i < r * columns + columns ; i++ ) {
            std::cout << allNumbers[i] << ' ' ;
        }
        std::cout << "]\n" ;
    }
    std::cout << ")\n" ;
    return 0 ;
}
