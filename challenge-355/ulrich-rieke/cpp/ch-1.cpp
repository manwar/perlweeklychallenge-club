#include <string>
#include <iostream>
#include <vector>

void chopInThree( std::string & numberstring ) {
    int len = numberstring.length( ) ;
    for ( int i = 0 ; i < len ; i++ ) {
        if ( i % 3 == 0 && i != len - 1 && i != 0) {
            numberstring.insert( i , "," ) ;
        }
    }
}

std::string separate( int number ) {
    std::string numberstring { std::to_string( number ) } ;
    int len = numberstring.length( ) ;
    if ( len < 3 ) {
        return numberstring ;
    }
    else {
        std::string withCommas ;
        int leading_part = len % 3 ;
        if ( leading_part != 0 ) {
            std::string firstpart { numberstring.substr( 0 , leading_part ) } ;
            firstpart.push_back( ',' ) ;
            std::string rest { numberstring.substr( leading_part ) } ;
            chopInThree( rest ) ;
            withCommas = firstpart + rest ;
        }
        else {
            withCommas = numberstring ;
            chopInThree( withCommas ) ;
        }
        return withCommas ;
    }
}

int main( ) {
    std::vector<int> numbers { 123 , 1234 , 1000000 , 1 , 12345 } ;
    for ( int i : numbers ) 
        std::cout << separate( i ) << '\n' ;
    return 0 ;
}
