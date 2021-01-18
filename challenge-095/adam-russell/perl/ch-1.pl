use strict;
use warnings;
##
# You are given a number $N.
# Write a script to figure out if the given number is Palindrome. 
# Print 1 if true otherwise 0.
##
use boolean;

sub is_palindrome{
    my($n) = @_;
    return false if $n < 0;
    my @digits = split(//, $n);
    if(@digits % 2 == 0){
        do{
            my $a = shift @digits;
            my $b = pop @digits;
            return false if $a != $b;
        }while(@digits);
        return true;
    }
    while(@digits != 1){
        my $a = shift @digits;
        my $b = pop @digits;
        return false if $a != $b;
    };
    return true;
}

MAIN:{
    print is_palindrome(1221);
    print "\n";
    print is_palindrome(-101);
    print "\n";
    print is_palindrome(90);
    print "\n";
}
