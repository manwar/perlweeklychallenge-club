#!/usr/bin/env perl
package Numbers; 

use strict; 
use warnings;
use v5.10;
 for my $i (1..10) {
   for my $j (1..10) {
     for my $k (1..10) { 
       if (($i+$j+$k) == 12) {
         if ( $i % 2 == 0 or $j % 2 == 0 or $k % 2 == 0 ) {
           my @m = ($i,$j,$k);
           @m = sort { $a <=> $b } @m;    
           print ("@m\n");
}
}
}
}
}
END 