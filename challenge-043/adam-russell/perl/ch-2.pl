use strict;
use warnings;
##
# Write a script to generate self-descriptive numbers.    
##
use boolean; 

sub self_describing{
    my($i) = @_;
    my @digits = split(//, $i); 
    for my $x (0 .. @digits - 1){
        my $count = 0;
        for my $j (0 .. @digits - 1){
            $count++ if($digits[$j] == $x);
            return false if($count > $digits[$x]); 
        }
        return false if($count != $digits[$x]); 
    }   
    return true; 
}

MAIN:{
    for my $i (0 .. 100000000){
        if(self_describing($i)){
            print "Base " . length($i) . ": $i\n";
        }
    }
}
