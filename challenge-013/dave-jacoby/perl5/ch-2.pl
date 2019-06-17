#!/usr/bin/env perl

# Perl Weekly Challenge 013-2

# Write a script to demonstrate Mutually Recursive methods. 
# Two methods are mutually recursive if the first method calls 
# the second and the second calls first in turn. Using the 
# mutually recursive methods, generate Hofstadter Female 
# and Male sequences.

##  F ( 0 ) = 1   ;   M ( 0 ) = 0
##  F ( n ) = n − M ( F ( n − 1 ) ) , n > 0
##  M ( n ) = n − F ( M ( n − 1 ) ) , n > 0.

# Thinking through this problem

# ff(1) = 1 - mm( ff( 0 ) )
# ff(1) = 1 - mm( 1 )
# mm(1) = 1 - ff( mm( 0 ) )
# mm(1) = 1 - ff( 0 )
# mm(1) = 1 - 1
# mm(1) = 0
# ff(1) = 1 - 0
# ff(1) = 1 

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch fc };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

for my $n ( 0 .. 3 ) {
    my $f = ff($n);
    my $m = mm($n);
    # say '';
    say qq{ f( $n ) = $f \t m( $n ) = $m };
}

exit;

sub ff( $n ) {
    # print qq{ ff($n) };
    return 1 if $n == 0 ;
    return $n - mm( ff( $n-1 ));
}

# using mm() because m() is a match operator, and using ff() to
# keep consistent, even though there isn't an f() operator.
sub mm( $n ) {
    # print qq{ mm($n) };
    return 0 if $n == 0 ;
    return $n - ff( mm( $n-1 ));
}

__DATA__
 ff(0)  mm(0) 
 f( 0 ) = 1 	 m( 0 ) = 0 
 
 ff(1)  ff(0)  mm(1)  mm(0)  ff(0)  mm(1)  mm(0)  ff(0) 
 f( 1 ) = 1 	 m( 1 ) = 0 

  ^^^ Verified

 ff(2)  ff(1)  ff(0)  mm(1)  mm(0)  ff(0)  mm(1)  mm(0)  ff(0)  mm(2)  mm(1)  mm(0)  ff(0)  ff(0) 
 f( 2 ) = 2 	 m( 2 ) = 1 

 ff(3)  ff(2)  ff(1)  ff(0)  mm(1)  mm(0)  ff(0)  mm(1)  mm(0)  ff(0)  mm(2)  mm(1)  mm(0)  ff(0)  ff(0)  mm(3)  mm(2)  mm(1)  mm(0)  ff(0)  ff(0)  ff(1)  ff(0)  mm(1)  mm(0)  ff(0) 
 f( 3 ) = 2 	 m( 3 ) = 2 
