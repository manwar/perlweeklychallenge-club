#include <iostream> 
#include <string> 
#include <vector>

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

void print( const std::vector<int> & numbers ) {
   std::cout << "  ( " ;
   for ( int i : numbers ) {
      std::cout << i << " " ;
   }
   std::cout << ")\n" ;
}

int main( ) {
   std::cout << "Enter a matrix by inputting an equal number of integers per line!\n" ;
   std::cout << "Enter <return> to end!\n" ;
   std::vector<std::vector<int>> matrix ;
   std::string line ;
   std::getline( std::cin , line ) ;
   while ( line.length( ) > 0 ) {
      std::vector<std::string> linenumbers ( split( line , " " ) ) ;
      std::vector<int> numbers ;
      for ( auto s : linenumbers ) 
	 numbers.push_back( std::stoi( s ) ) ;
      matrix.push_back( numbers ) ;
      std::getline( std::cin , line ) ;
   }
   int matrixlen = matrix.size( ) ;
   int rowlen = matrix[0].size( ) ;
   std::vector<std::vector<int>> result ;
   for ( int r = 0 ; r < matrixlen - 1 ; r++ ) {
      std::vector<int> resultline ;
      for ( int col = 0 ; col < rowlen - 1 ; col++ ) {
	 int sum = matrix[ r ][col] + matrix[r][ col + 1 ] +
	    matrix[ r + 1][ col ] + matrix[ r + 1 ][ col + 1 ] ;
	 resultline.push_back( sum ) ;
      }
      result.push_back( resultline ) ;
   }
   std::cout << "(\n" ;
   for ( const auto & numline : result ) {
      print( numline ) ;
   }
   std::cout << ")\n" ;
   return 0 ;
}

