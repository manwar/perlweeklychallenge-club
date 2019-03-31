perl -e 'for $x (1..20){unless($x % 5 == 0 or $x % 3 == 0) {print $x; } else { print "Fizz" if( $x % 3 ==0); print "Buzz" if( $x % 5 == 0); }}'
