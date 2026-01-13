#include <iostream>
#include <utility>
#include <algorithm>
#include <string>
#include <vector>
#include <format>

//seeding order based on the results of given ties
std::vector<int> find_ties( const std::string & result , const std::vector<
        std::pair<int , int>> & ties ) {
    std::vector<int> seedings ;
    std::vector<std::pair<char , std::pair<int , int>>> result_pairs ;
    for ( int i = 0 ; i < result.length( ) ; i++ ) {
        result_pairs.push_back( std::make_pair( result[i] , ties[i] )) ;
    }
    for ( auto it = result_pairs.begin( ) ; it != result_pairs.end( ) ; ++it ) {
        if ( it->first == 'H' ) {
            seedings.push_back( (it->second).first ) ;
        }
        else {
            seedings.push_back( (it->second).second ) ;
        }
    }
    std::sort( seedings.begin( ) , seedings.end( ) ) ;
    return seedings ;
}

std::string find_result( const std::string & input ) {
    std::vector<std::pair<int , int>> first_round_ties { std::pair( 2 , 7 ) , 
        std::pair( 3 , 6 ) , std::pair( 4 , 5 ) } ;
    auto first_round_seedings { find_ties( input.substr( 0 , 3 ) , 
            first_round_ties ) } ;
    std::vector<std::pair<int , int>> second_round_ties { std::make_pair( 1 , 
            first_round_seedings[2] ) , std::make_pair( first_round_seedings[0] , 
                first_round_seedings[1] ) } ;
    auto second_round_seedings { find_ties( input.substr( 3 , 2 ) , 
            second_round_ties ) } ;
    std::string result ;
    std::sort( second_round_seedings.begin( ) , second_round_seedings.end( ) ) ;
    if ( input.substr( 5 , 1 ) == "H" ) {
        result = std::format( "Team {} defeated Team {}" , second_round_seedings[0] , 
                second_round_seedings[1] ) ;
    }
    else {
        result = std::format( "Team {} defeated Team {}" , second_round_seedings[1] , 
                second_round_seedings[0] ) ;
    }
    return result ;
}

int main( ) {
    std::vector<std::string> input {"HAHAHH" , "HHHHHH" , "HHHAHA" , "HAHAAH" , 
        "HAAHAA" } ;
    for ( auto s : input ) {
        std::cout << find_result( s ) << '\n' ;
    }
    return 0 ;
}
