#include <vector>
#include <sstream>
#include <string>
#include <map>
#include <algorithm>
#include <iostream>
#include <iterator>
#include <set>

std::vector<std::string> split( std::string text , const char delimiter) {
   std::stringstream instr { text } ;
   std::vector<std::string> tokens ;
   std::string word ;
   while ( std::getline( instr , word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

int main( ) {
   std::cout << "Enter a list of integers, separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   std::vector<std::string> firstNums { split( line , ' ' ) } , 
      secondNums ;
   std::cout << "Enter a list of unique integers that are a subset of the "
      << "first list!\n" ;
   std::getline( std::cin , line ) ;
   secondNums = split( line , ' ' ) ;
   std::vector<int> firstNumbers , secondNumbers ;
   for ( auto s : firstNums ) 
      firstNumbers.push_back( std::stoi( s ) ) ;
   for ( auto s : secondNums ) 
      secondNumbers.push_back( std::stoi( s ) ) ;
   std::map<int , int> frequencies ;
   for ( int i : firstNumbers ) 
      frequencies[i]++ ;
   std::vector<int> result ; // final numbers for the output
   for ( int n : secondNumbers ) {
      for ( int i = 0 ; i < frequencies.find( n )->second ; i++ ) 
	 result.push_back( n ) ;
   }
   //we now look for the numbers in firstNumbers not in secondNumbers
   std::vector<int> difference ;
   std::set<int> firstSet { firstNumbers.begin( ) , firstNumbers.end( ) } ;
   std::set<int> secondSet { secondNumbers.begin( ) , secondNumbers.end( ) } ;
   auto pos = std::set_difference( firstSet.begin( ) , 
	 firstSet.end( ) , secondSet.begin( ) ,
	 secondSet.end( ) , std::inserter( difference ,
	    difference.begin( ) ) ) ;
   for ( int i : difference ) {
      for ( int n = 0 ; n < frequencies.find( i )->second ; n++ ) 
	 result.push_back( i ) ;
   }
   std::cout << '(' ;
   std::copy( result.begin( ) , result.end( ) ,
	 std::ostream_iterator<int>( std::cout , " " ) ) ;
   std::cout << ")\n" ;
   return 0 ;
}
