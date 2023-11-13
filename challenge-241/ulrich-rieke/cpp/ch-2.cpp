#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

std::vector<std::string> split( const std::string & startline ,
      const std::string & sep ) {
   std::vector<std::string> separated ;
   std::string::size_type start { 0 } ;
   std::string::size_type pos ;
   do {
      pos = startline.find_first_of( sep , start ) ;
      separated.push_back( startline.substr(start , pos - start )) ;
      start = pos + 1 ;
   } while ( pos != std::string::npos ) ;
   return separated ;
}

int findSmallest( int number ) {
   int divisor = 2 ;
   while ( number % divisor != 0 ) {
      divisor++ ;
   }
   return divisor ;
}

std::vector<int> primeDecompose( int number ) {
   std::vector<int> primeFactors ;
   while ( number != 1 ) {
      int divisor = findSmallest( number ) ;
      primeFactors.push_back( divisor ) ;
      number /= divisor ;
   }
   return primeFactors ;
}

bool mySorter( int numA , int numB ) {
   std::vector<int> factorsA { primeDecompose( numA ) } ;
   std::vector<int> factorsB { primeDecompose( numB ) } ;
   if ( factorsA.size( ) != factorsB.size( ) ) {
      return factorsA.size( ) < factorsB.size( ) ;
   }
   else {
      return numA < numB ;
   }
}

int main( ) {
   std::cout << "Enter some unique positive integers greater than 2!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> numberstrings( split( line , " " ) ) ;
   std::vector<int> numbers ;
   for ( auto s : numberstrings ) 
      numbers.push_back( std::stoi( s ) ) ;
   std::sort( numbers.begin( ) , numbers.end( ) , mySorter ) ;
   std::cout << "( " ;
   for ( int i : numbers ) 
      std::cout << i << ' ' ;
   std::cout << " )\n" ;
   return 0 ;
}

