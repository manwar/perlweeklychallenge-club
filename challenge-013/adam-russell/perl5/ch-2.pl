use strict;
use warnings;
##
# Using mutually recursive methods, generate Hofstadter Female and Male sequences.
##

sub F{
    my($n) = @_;
    if($n == 0){
        return 1;  
    } 
    return $n - M(F($n - 1));  
}

sub M{ 
    my($n) = @_;
    if($n == 0){
        return 0;  
    }  
    return $n - F(M($n - 1));  
}

##
# Main
## 
for my $n (0 .. 25){  
    print "$n\tM: " . M($n) . "\tF: " . F($n) . "\n";
}   
