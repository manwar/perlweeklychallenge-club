#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <utility>

std::vector<std::string> split( const std::string & text , const char 
      delimiter) {
   std::vector<std::string> tokens ;
   std::istringstream istr { text } ;
   std::string word ;
   while ( std::getline( istr, word , delimiter ) ) 
      tokens.push_back( word ) ;
   return tokens ;
}

std::vector<std::vector<std::pair<int , int>>> getCombinations(
      const std::vector<std::pair<int , int>> & elements, int d) {
    std::vector<std::vector<std::pair<int , int>>> result;
    int n = elements.size();
    std::vector<int> indices(d);
    for (int i = 0; i < d; i++) {
        indices[i] = i;
    }
    while (true) {
        std::vector<std::pair<int , int>> combination;
        for (int i = 0; i < d; i++) {
            combination.push_back(elements[indices[i]]);
        }
        result.push_back(combination);
        // Generate next combination
        int i = d - 1;
        while (i >= 0 && indices[i] == n - d + i) {
            i--;
        }
        // If we've exhausted all combinations, break
        if (i < 0) {
            break;
        }
        // Increment and reset
        indices[i]++;
        for (int j = i + 1; j < d; j++) {
            indices[j] = indices[j - 1] + 1;
        }
    }
    return result;
}

int main( ) {
   std::cout << "Enter some integers separated by blanks!\n" ;
   std::string line ;
   std::getline( std::cin , line ) ;
   auto tokens { split( line , ' ' ) } ;
   std::vector<int> numbers ;
   for ( auto w : tokens ) 
      numbers.push_back( std::stoi( w ) ) ;
   int len = numbers.size( ) ;
   //according to the examples, subsets in the sense of this task are subsets with at
   //least 2 elements and no more than n - 1 elements where n is the size of the array
   std::vector<std::pair<int , int>> elements ;
   for ( int i = 0 ; i < len ; i++ ) 
      elements.push_back( std::make_pair( i + 1 , numbers[i] ) ) ;
   std::vector<std::vector<std::pair<int , int>>> allCombinations ;
   std::vector<std::vector<int>> solution ;
   for ( int d = 2 ; d < len  ; d++ ) {
      auto currentCombis{getCombinations ( elements , d ) } ;
         for ( auto combi : currentCombis ) {
            int indexsum = 0 ;
            int numbersum = 0 ;
            for ( auto it = combi.begin( ) ; it != combi.end( ) ; ++it ) {
               indexsum += it->first ;
               numbersum += it->second ;
            }
            if ( indexsum == numbersum ) {
               std::vector<int> result ;
               for ( auto it = combi.begin( ) ; it != combi.end( ) ; ++it ) {
                  result.push_back( it->second ) ;
               }
               solution.push_back( result ) ;
            }
         }
   }
   std::cout << "( " ;
   for ( auto subvec : solution ) {
      std::cout << "( " ;
      for ( int i : subvec ) {
         std::cout << i << ' ' ;
      } 
      std::cout << ") " ;
   }
   std::cout << ")\n" ;
   return 0 ;
}
