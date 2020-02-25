use strict;
use warnings;
##
# Write a script to generate a string with a random 
# number of ( and ) parentheses. Make the script validate 
# the string for balanced parentheses.
##
use boolean; 
use constant LENGTH => 4;
use constant OPEN => "(";
use constant CLOSE => ")";  

sub build{
    my $s;
    for (0 .. (LENGTH - 1)){
        my $p = rand() < 0.5 ? OPEN : CLOSE;  
        $s .= $p;
    }
    return $s;   
}

sub validate{
    my($s) = @_; 
    my @a; 
    for my $c (split(//, $s)){
        push @a, $c if($c eq OPEN);  
        if($c eq CLOSE){
            return false if(!@a || pop @a ne OPEN);     
        }  
    }
    return true if !@a;     
    return false;
}

MAIN:{
    my $s = build();
    my $r = validate($s) ?  "balanced" : "not balanced"; 
    print "$s is $r\n"; 
} 
