#include <iostream>
#include <regex>
#include <string>
#include <vector>
#include <algorithm>
#include <iterator>
using namespace std::string_literals ;

int monthIndex( const std::string & mo ) {
    static std::vector<std::string> monthnames { "Jan" , "Feb" , "Mar" , "Apr" , "May" ,
        "Jun" , "Jul" , "Aug" , "Sep" , "Oct" , "Nov" , "Dec" } ;
    auto found = std::find( monthnames.begin( ) , monthnames.end( ) , mo ) ;
    int n = static_cast<int>(std::distance( monthnames.begin( ) , found )) ;
    return n + 1 ;
}

std::string parseDate( const std::string & date ) {
    auto re = std::regex {R"(^(\d{1,2})[stndrh]{2}\s(\w{3})\s([12][901]\d{2})$)"}  ;
    std::smatch sm ;
    std::regex_search( date , sm , re ) ;
    std::string day { sm.str( 1 ) } ;
    std::string monthtoLookFor { sm.str( 2 ) } ;
    std::string year { sm.str( 3 ) } ;
    int index = monthIndex( monthtoLookFor ) ;
    std::string month { std::to_string( index ) } ;
    if ( month.length( ) == 1 ) 
        month = "0"s += month ;
    if ( day.length( ) == 1 ) 
        day = "0"s += day ;
    std::string result ;
    result += year + "-"s + month + "-"s + day ;
    return result ;
}

int main( ) {
    std::cout << parseDate( "1st Jan 2025" ) << '\n' ;
    std::cout << parseDate( "22nd Feb 2025" ) << '\n' ;
    std::cout << parseDate( "15th Apr 2025") << '\n' ;
    std::cout << parseDate( "23rd Oct 2025" ) << '\n' ;
    std::cout << parseDate( "31st Dec 2025") << '\n' ;
    return 0 ;
}
