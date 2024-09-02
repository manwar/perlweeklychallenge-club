#include <iostream>

int main( ) {
   int amount ;
   std::cout << "Enter an amount of money in pennies!\n" ;
   std::cin >> amount ;
   int combis = 0 ;
   for (int pennies = 0 ; pennies < amount + 1 ; pennies++ ) {
      for ( int nickels = 0 ; nickels < (amount / 5 ) + 1 ; nickels++ ) {
	 for ( int dimes = 0 ; dimes < ( amount / 10 ) + 1 ; dimes++ ) {
	    for ( int quarters = 0 ; quarters < ( amount / 25 ) + 1 ;
		  quarters++ ) {
	       for ( int half_dollars = 0 ; half_dollars < ( amount / 50 )
		     + 1 ; half_dollars++ ) {
		  if ( pennies + nickels * 5 + dimes * 10 + 
			quarters * 25 + half_dollars * 50 == amount ) 
		     combis++ ;
	       }
	    }
	 }
      }
   }
   std::cout << combis << '\n' ;
   return 0 ;
}

