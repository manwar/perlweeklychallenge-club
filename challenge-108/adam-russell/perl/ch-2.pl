use strict;
use warnings;
##
# Write a script to display the first 10 Bell Numbers.
##
sub bell_triangle{
    my($n) = @_; 
    my @bell_numbers = ([]);
    $bell_numbers[0]->[0] = 1;
    for (my $i=1; $i<=$n; $i++) {
      $bell_numbers[$i]->[0] = $bell_numbers[$i-1]->[$i-1];
      for (my $j=1; $j<=$i; $j++){  
          $bell_numbers[$i]->[$j] = $bell_numbers[$i-1]->[$j-1] + $bell_numbers[$i]->[$j-1];
       }
   }
   return $bell_numbers[$n]->[0];
}

MINA:{
    for my $b (0 .. 9){  
        print "B_$b: " . bell_triangle($b) . "\n";  
    } 
}
