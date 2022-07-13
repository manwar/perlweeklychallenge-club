#include <iostream>
#include <boost/multiprecision/cpp_int.hpp>

int main( ) {
  //to avoid a wraparound for the rapidly increasing numbers even
  //the data type long long isn't long enough , so an extra library
  //from boost had to do the job of creating long ints of sufficient
  //precision
  using boost::multiprecision::cpp_int ;
  int x = 2 ;
  std::cout << x << std::endl ;
  int y = 3 ;
  std::cout << y << std::endl ;
  cpp_int lastProduct = static_cast<cpp_int>(x * y) ;
  int count = 0 ;
  while ( count != 8 ) {
      cpp_int newElement = lastProduct + 1 ;
      std::cout << newElement << std::endl ;
      lastProduct *= newElement ;
      count++ ;
  }
  return 0 ;
}
