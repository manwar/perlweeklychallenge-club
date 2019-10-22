#!/usr/bin/env perl6

use v6;

#| Takes 8 points for the lines (a,b) -> (c,d) and (p,q) -> (r,s)
#| Outputs the intersection
sub MAIN( Rat() \a, Rat() \b, Rat() \c, Rat() \d,
          Rat() \p, Rat() \q, Rat() \r, Rat() \s ) {

    my \a1 = d - b; 
    my \b1 = a - c; 
    my \c1 = a1*(a) + b1*(b); 
  
    my \a2 = s - q; 
    my \b2 = p - r; 
    my \c2 = a2*(p)+ b2*(q); 
  
    my \determinant = a1*b2 - a2*b1; 

    say "Lines ({a},{b}) -> ({c},{d}) and ({p},{q}) -> ({r},{s})";
    
    if ( determinant == 0 ) {
        say "Lines are parallel. No intersection";
    } else {
        my \x = (b2*c1 - b1*c2)/determinant; 
        my \y = (a1*c2 - a2*c1)/determinant; 
        say "Intersection at ({x},{y})";
    }
}
