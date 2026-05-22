#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <algorithm>

int convert( const char letter , int howmany ) {
   if ( letter == '0' ) {
      return 0 ;
   }
   else {
      std::string numberstring ;
      for ( int i = 0 ; i < howmany ; i++ ) 
         numberstring.push_back( letter ) ;
      return std::stoi( numberstring ) ;
   }
}

int main( ) {
   std::cout << "Enter a string consisting of grouped digits only!\n" ;
   std::string numberstring ;
   std::cin >> numberstring ;
   std::map<char , int> frequencies ;
   for ( char c : numberstring ) 
      frequencies[c]++ ;
   std::vector<int> numbers ;
   for ( auto it = frequencies.begin( ) ; it != frequencies.end( ) ; ++it ) {
      numbers.push_back( convert( it->first , it->second ) ) ;
   }
   std::cout << *std::max_element( numbers.begin( ) , numbers.end( ) ) << '\n' ;
   return 0 ;
}
