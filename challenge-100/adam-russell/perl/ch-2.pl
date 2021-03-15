use strict;
use warnings;
##
# Given a triangle array write a script to find
# the minimum path sum from top to bottom.
# When you are on index i on you may only
# move to either index i or i+1 on the next row.
#
sub minimum_sum{
    my(@triangle) = @_;
    my($i, $j) = (0, 0);
    my $sum = $triangle[0]->[0]; 
    while($i < @triangle){
        unless(!exists($triangle[$i+1])){
            $j = ($triangle[$i+1]->[$j] >= $triangle[$i+1]->[$j+1]) ? $j+1 : $j; 
            $sum += $triangle[$i+1]->[$j]; 
        } 
        $i++;
    }  
    return $sum;
}

MAIN:{
    my(@TRIANGLE);
    @TRIANGLE = ([1], [2, 4], [6, 4, 9], [5, 1 , 7, 2]); 
    print minimum_sum(@TRIANGLE) . "\n"; 

    @TRIANGLE =([3], [3, 1], [5, 2, 3], [4, 3, 1, 3]); 
    print minimum_sum(@TRIANGLE) . "\n"; 
}
