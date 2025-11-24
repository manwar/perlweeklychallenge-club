#include <iostream>
#include <functional>
#include <string>
#include <map>
#include <utility> 

std::pair<int, int> up( const std::pair<int , int> & point ) {
    return std::make_pair( point.first , point.second + 1 ) ;
}

std::pair<int , int> down( const std::pair<int , int> & point ) {
    return std::make_pair( point.first , point.second - 1 ) ;
}

std::pair<int , int> left( const std::pair<int , int> & point ) {
    return std::make_pair( point.first - 1 , point.second ) ;
}

std::pair<int , int> right( const std::pair<int , int> & point ) {
    return std::make_pair( point.first + 1 , point.second ) ;
}

int main( ) {
    std::cout << "Enter some letters U , R , D or L to denote motions!\n" ;
    std::string motions ;
    std::cin >> motions ;
    std::map<char, std::function<std::pair<int , int>(const std::pair<int , 
            int> )>> movedirs ;
    movedirs['U'] = up ;
    movedirs['D'] = down ;
    movedirs['L'] = left ;
    movedirs['R'] = right ;
    std::pair<int , int> current { std::make_pair( 0 , 0 ) } ;
    for ( char c : motions ) {
        current = movedirs[c](current) ;
    }
    std::cout << std::boolalpha << ( current.first == 0 && current.second 
            == 0 ) << '\n' ;
    return 0 ;
}
