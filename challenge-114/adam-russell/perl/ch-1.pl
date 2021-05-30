use strict;
use warnings;
##
# You are given a positive integer $N.
# Write a script to find out the next Palindrome Number 
# higher than the given integer $N.
##
sub next_palindrome{
    my($n) = @_;
    {
        $n++;
        return $n if $n eq join("", reverse(split(//, $n)));
        redo; 
    }   
}

MAIN:{
    my($N);
    $N = 1234;
    print next_palindrome($N) . "\n"; 
    $N = 999;
    print next_palindrome($N) . "\n"; 
}  
