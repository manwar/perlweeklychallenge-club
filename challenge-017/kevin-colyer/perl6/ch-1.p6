#!/usr/bin/perl6
use v6;

use Test;

#Task #1
# Create a script to demonstrate Ackermann function. The Ackermann function is defined as below, m and n are positive number:
#
#   A(m, n) = n + 1                  if m = 0
#   A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
#   A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0

#| Ackermann function
multi MAIN( $m, $n ) {
    say Ackermann($m,$n);
}

multi Ackermann($m where $m==0,$n)              { return $n + 1 }
multi Ackermann($m where $m>0, $n where $n==0)  { return Ackermann( $m - 1, 1 ) }
multi Ackermann($m where $m>0, $n where $n>0)   { return Ackermann( $m - 1, Ackermann( $m, $n - 1 ) ) }


multi MAIN ( "test" ) {
 is Ackermann( 0, 0 ),1,"0,0=1";
 is Ackermann( 1, 0 ),2,"1,0=2";
 is Ackermann( 3, 3 ),61,"3,3=61";
 is Ackermann( 0, 1 ),2,"0,1=2";
 is Ackermann( 0, 4 ),5,"0,4=5";
 is Ackermann( 1, 2 ),4,"1,2=4";

}
