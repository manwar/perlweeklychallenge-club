#include <string>
#include <iostream>

bool solution( const std::string & word ) {
    static std::string vowels {"aAeEiIoOuU"} ;
    int len = static_cast<int>( word.length( ) ) ;
    int firstvowels = 0 ;
    int secondvowels = 0 ;
    for ( char d : word.substr( 0 , len / 2 )) {
        if ( vowels.find( d ) != std::string::npos ) {
            firstvowels++ ;
        }
    }
    for ( char d : word.substr( len / 2 )) {
        if ( vowels.find( d ) != std::string::npos ) {
            secondvowels++ ;
        }
    }
    return firstvowels == secondvowels ;
}

int main( ) {
    std::cout << std::boolalpha << solution( "textbook" ) << '\n' ;
    std::cout << std::boolalpha << solution( "book" ) << '\n' ;
    std::cout << std::boolalpha << solution( "AbCdEfGh" ) << '\n' ;
    std::cout << std::boolalpha << solution( "rhythmmyth" ) << '\n' ;
    std::cout << std::boolalpha << solution( "UmpireeAudio" ) << '\n' ;
    return 0 ;
}
