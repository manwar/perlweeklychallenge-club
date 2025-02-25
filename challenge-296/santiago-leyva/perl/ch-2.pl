=begin
You are given an array of integers, @ints.

Write a script to find if it is possible to make one square using the sticks as in the given array @ints where $ints[ì] is the length of ith stick.

Example 1
Input: @ints = (1, 2, 2, 2, 1)
Output: true

Top: $ints[1] = 2
Bottom: $ints[2] = 2
Left: $ints[3] = 2
Right: $ints[0] and $ints[4] = 2
Example 2
Input: @ints = (2, 2, 2, 4)
Output: false
Example 3
Input: @ints = (2, 2, 2, 2, 4)
Output: false
Example 4
Input: @ints = (3, 4, 1, 4, 3, 1)
Output: true
=cut

use strict;
use warnings;
use Data::Dumper;

my @input = ([1, 2, 2, 2, 1],[2, 2, 2, 4],[2, 2, 2, 2, 4],[3, 4, 1, 4, 3, 1]);
#4, 4, 3, 3, 1, 1
foreach(@input){
    my @arr = @$_;
    my $result = formSquare(\@arr);
    print "For sticks [",join(" ",@arr),"] -> $result\n";
}


sub formSquare {
    my @A = @$_;
    
    return "false" if scalar @A < 4;
    
    @A = sort {$b <=> $a} @A;  
    #square has four sides
    # s1 s2 s3 s4
    my $s1 = $A[0];
    my $s2 = $A[1];
    my $s3 = $A[2];
    my $s4 = $A[3];
    my $total = ($s1+$s2+$s3+$s4)/4;
    my $n = scalar @A;
    if($total == $s1 and ($n == 4)){
        return "true" 
    }elsif($total != $s1 and ($n == 4)){
        return "false";
    }
    #check if can form the square
    my $largest = $s1;
    my %need;
    #4, 4, 3, 3, 1, 1
    for(my $i=1;$i<(scalar @A);$i++){
        if($i > 3){
            #print Dumper \%need;
            if(exists($need{$A[$i]})){
               $need{$A[$i]} -= 1;
               if($need{$A[$i]} == 0){
                delete $need{$A[$i]};
               } 
            }else{
                return "false";
            }
        }else{
            if ($A[$i] != $largest){
                my $remain = $largest - $A[$i];
                $need{$remain} += 1;
            }
        }
        
    }
    if(keys %need){ #left over sticks
        return "false";
    }
    return "true";

}
