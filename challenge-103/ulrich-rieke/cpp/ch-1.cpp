#include <vector>
#include <string>
#include <iostream>
#include <cstdlib>

int main( int argc, char * argv[] ) {
  int year = std::atoi( argv[1] ) ;
  std::vector<std::string> animals {"Rat" , "Ox" , "Tiger" , "Rabbit" , "Dragon" , "Snake",
      "Horse" , "Goat" , "Monkey" , "Rooster", "Dog" , "Pig" } ;
  std::vector<std::string> elements {"Wood" , "Fire" , "Earth" , "Metal" , "Water" } ;
  int elementlen = elements.size( ) ;
  int animallen = animals.size( ) ;
  int yeardiff = year - 1924 ;
  int animalindex = yeardiff % animallen ;
  int elementindex = ( yeardiff / 2 )  % elementlen ;
  std::cout << elements[ elementindex ] << " " << animals[ animalindex ] << std::endl ;
  return 0 ;
}
