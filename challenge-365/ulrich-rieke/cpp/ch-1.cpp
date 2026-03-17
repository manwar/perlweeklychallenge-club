#include <iostream>
#include <string>

int convert( const std::string & input ) {
   std::string converted ;
   for ( auto it = input.begin( ) ; it != input.end( ) ; ++it ) {
      converted += std::to_string( static_cast<int>(*it) - 96 ) ;
   }
   return std::stoi(converted) ;
}

int digitsum( int number ) {
   int sum = 0 ;
   while ( number != 0 ) {
      sum += number % 10 ;
      number /= 10 ;
   }
   return sum ;
}

int main( ) {
   std::cout << "Enter a word with lowercase English letters only!\n" ;
   std::string word ;
   std::cin >> word ;
   std::cout << "Enter a positive integer!\n" ;
   int k ;
   std::cin >> k ;
   int result = digitsum( convert( word ) ) ;
   k-- ;
   while ( k != 0 ) {
      result = digitsum( result ) ;
      k-- ;
   }
   std::cout << result << '\n' ;
   return 0 ;
}
