#include <iostream>
#include <cmath>

int main( ) {
   std::cout << "Please enter an integer!\n" ;
   int number ;
   std::cin >> number ;
   double third = 1.0 / 3.0 ;
   double cuberoot = std::pow( static_cast<double>(number ) , third ) ;
   if ( cuberoot == floor( cuberoot ) ) 
      std::cout <<  "true\n" ;
   else 
      std::cout <<  "false\n" ;
   return 0 ;
}
