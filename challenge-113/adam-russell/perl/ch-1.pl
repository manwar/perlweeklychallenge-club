use strict;
use warnings;
##
# You are given a positive integer $N and a digit $D.
# Write a script to check if $N can be represented as 
# a sum of positive integers having $D at least once. 
# If the check passes print 1 otherwise 0.  
##
sub is_represented{
    my($n, $d) = @_;  
    my @contains = grep { grep { $_ == $d } split(//) } (1 .. $n);    
    return $n == unpack("%32C*", pack("C*",  @contains));
}

MAIN:{
    print is_represented(25, 7) + 0 . "\n";  
    print is_represented(24, 7) + 0 . "\n";  
}
