#include <string>
#include <set>
#include <iostream>
#include <vector>

bool areShuffled( int firstnumber , int secondnumber ) {
    std::string firstString { std::to_string( firstnumber ) } ;
    std::string secondString { std::to_string( secondnumber ) } ;
    if ( firstString.length( ) == secondString.length( )) {
        std::set<char> firstSet { firstString.begin( ) , firstString.end( ) } ;
        std::set<char> secondSet { secondString.begin( ) , secondString.end( ) } ;
        return ( firstSet == secondSet && firstSet.size( ) == firstString.length( ) ) ;
    }
    else {
        return false ;
    }
}

int findPairs( int from , int to , int count ) {
    std::vector<int> pairs ;
    for ( int i = from ; i < to + 1 ; i++ ) {
        int found = 0 ;
        for ( int mult = 2 ; mult < 10 ; mult++ ) {
            if ( areShuffled( i , mult * i ) ) {
                found++ ;
                if ( found == count ) {
                    pairs.push_back( i ) ;
                    break ;
                }
            }
        }
    }
    return static_cast<int>( pairs.size( ) ) ;
}

int main( ) {
    std::cout << findPairs( 1 , 1000 , 1 ) << '\n' ;
    std::cout << findPairs( 1500 , 2500 , 1 ) << '\n' ;
    std::cout << findPairs( 1000000 , 1500000 , 5 ) << '\n' ;
    std::cout << findPairs( 13427000 , 14100000 , 2 ) << '\n' ;
    std::cout << findPairs( 1030 , 1130 , 1 ) << '\n' ;
    return 0 ;
}


