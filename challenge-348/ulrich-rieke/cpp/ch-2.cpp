#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <numeric>

int main( ) {
    std::cout << "Enter a source time!\n" ;
    std::string source , target ;
    std::cin >> source ;
    std::cout << "Enter a target time!\n" ;
    std::cin >> target ;
    int sourcehours { std::stoi( source.substr( 0 , 2 )) } ;
    int sourceminutes { std::stoi( source.substr( 3 ) ) } ;
    int targethours { std::stoi( target.substr( 0 , 2 ) ) } ;
    int targetminutes { std::stoi( target.substr( 3 ) ) } ;
    if ( targethours < sourcehours ) {
        targethours += 24 ;
    }
    std::vector<int> ops { 1 , 5 , 15 , 60 } ;
    int diffminutes = targethours * 60 + targetminutes - ( sourcehours *
            60 + sourceminutes ) ;
    std::vector<int> operations ;
    while ( diffminutes != 0 ) {
        std::vector<int> smaller ;
        for ( auto n : ops ) {
            if ( n <= diffminutes ) {
                smaller.push_back( n ) ;
            }
        }
        int divisor = *std::max_element( smaller.begin( ) , smaller.end( )) ;
        operations.push_back( diffminutes / divisor ) ;
        diffminutes -= divisor * operations.back( ) ;
    }
    std::cout << std::accumulate( operations.begin( ) , operations.end( ) , 0 )
        << '\n' ;
    return 0 ;
}
