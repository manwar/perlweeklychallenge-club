use strict;
use warnings;
##
# Create a function to check divide by zero error 
# without checking if the denominator is zero.
##
eval { my($x, $y) = (9, 0); my $a = $x/$y; }; 
if($@){
    print "caught an error: $@"; 
}   
else{
    print "no error\n"; 
} 
