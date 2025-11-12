#include <string>
#include <iostream>
#include <regex>
#include <vector>
using namespace std::string_literals ;

std::string handleRest( const std::string & rest ) {
    std::string result ;
    char dash = '-' ;
    int len = static_cast<int>( rest.length( ) ) ;
    if ( len == 2 || len == 3 ) {
         result = rest ;
    }
    else {
        result = rest.substr(0 , 2 ) ;
        result.append(1, dash ) ;
        result += rest.substr( 2 ) ;
    }
    return result ;
}

void printParts( const std::vector<std::string> & parts ) {
    if ( parts.size( ) == 1 ) 
        std::cout << *parts.begin( ) << '\n' ;
    else {
        char dash { '-' } ;
        std::string result ;
        for ( auto s : parts ) {
            result += s ;
            result.append(1, dash ) ;
        }
        result.pop_back( ) ;
        std::cout << result << '\n' ;
    }
}

int main( ) {
    std::cout << "Enter a phone number consisting of digits , spaces and dashes only!\n" ;
    std::string phonenumber ;
    std::getline( std::cin , phonenumber ) ;
    auto rx = std::regex{ R"(\s|\-)"s} ;
    std::string reduced = std::regex_replace( phonenumber , rx , ""s ) ;
    int len = static_cast<int>( reduced.length( ) ) ;
    if ( len <= 4 ) {
        std::cout << handleRest( reduced ) << '\n' ;
    }
    else {
        std::vector<std::string> parts ;
        int partnumber = len / 3 ;
        int lengthrest = len % 3 ;
        if ( lengthrest != 0 && lengthrest < 2 ) 
            partnumber-- ;
        int pos = 0 ;
        int i = 0 ;
        while ( i < partnumber ) {
            parts.push_back( reduced.substr( pos , 3 ) ) ;
            pos += 3 ;
            i++ ;
        }
        int restlen = len - partnumber * 3 ;
        if ( restlen == 0 ) 
            printParts( parts ) ;
        else {
            std::string rest { reduced.substr( partnumber * 3 ) } ;
            parts.push_back( handleRest( rest )) ;
            printParts( parts ) ;
        }
    }
    return 0 ;
}
