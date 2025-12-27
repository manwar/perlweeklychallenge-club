#include <iostream>
#include <regex>
#include <string>
#include <sstream>
#include <algorithm>
#include <vector>
using namespace std::string_literals ;

std::vector<std::string> split( const std::string & text , const char delimiter ) {
    std::vector<std::string> tokens ;
    std::istringstream istr { text } ;
    std::string word ;
    while ( std::getline( istr , word , delimiter ) ) 
        tokens.push_back( word ) ;
    return tokens ;
}

int main( ) {
    std::cout << "Enter some codes separated by blanks!\n" ;
    std::string line ;
    std::getline( std::cin , line ) ;
    auto codes { split( line , ' ' ) } ;
    std::cout << "Enter some names separated by blanks!\n" ;
    std::getline( std::cin , line ) ;
    auto names { split( line , ' ' ) } ;
    std::cout << "Enter as many status codes true or false separated by blanks!\n" ;
    std::getline( std::cin , line ) ;
    auto status { split( line , ' ' ) } ;
    std::vector<bool> result ;
    std::regex re {R"(^\w+$)"s} ;
    int len = codes.size( ) ;
    const std::vector<std::string> categories { "pharmacy" , "restaurant" , 
        "grocery" , "electronics" } ;
    for ( int i = 0 ; i < len ; i++ ) {
        result.push_back( std::regex_match( codes[i] , re ) && std::find( 
                    categories.begin( ) , categories.end( ) , names[i] ) != 
                categories.end( ) && status[i] == "true" ) ;
    }
    std::cout << "( " ;
    for ( auto b : result )
        std::cout << std::boolalpha << b << ' ' ;
    std::cout << ")\n" ;
    return 0 ;
}

