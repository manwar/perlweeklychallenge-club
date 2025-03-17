#include <iostream>
#include <string>
#include <set>

//the basic idea is : if the set of the letters of both words is identical
//and the length of the words is different then the result is true else
//false!
int main( ) {
   std::cout << "Enter a word!\n" ;
   std::string firstWord , secondWord ;
   std::cin >> firstWord ;
   std::cout << "Enter a second word with possible typing errors!\n" ;
   std::cin >> secondWord ;
   std::set<char> firstSet( firstWord.begin( ) , firstWord.end( ) ) ;
   std::set<char> secondSet( secondWord.begin( ) , secondWord.end( ) ) ;
   std::cout << std::boolalpha << ( firstSet == secondSet && 
	 firstWord.length( ) != secondWord.length( ) ) << '\n' ;
   return 0 ;
}
