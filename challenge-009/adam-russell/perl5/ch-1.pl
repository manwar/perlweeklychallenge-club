use strict;
use warnings;
use feature "switch";  

use constant X_0 => 1_000_001; 

sub is_first_five{
    my($n) = @_;
    my $a = length(($n-1)**2);
    my $b = length($n**2);
    if($a == 4 && $b == 5){
        return 0;
    }
    if($a >= 4 && $b >= 5){
        return 1;
    }
    if($a <= 4 && $b <= 5){
        return -1;
    }
}


##
# Main
##
my $x = X_0;
my $found = 0;
do{
    my $b = is_first_five($x);  
    given($b){
        when(1){
            $x = int($x / 2) - 1;  
        }
        when(-1){
            $x = ($x * 2);  
        }
        when(0){  
            $found = 1;  
        }  
    }  
}until($found);  
print "FOUND: ";
print $x**2 . "\n"; 
