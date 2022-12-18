use v5.36;
##
# You are given a positive integer, $n > 0.
# Write a script to print the count of all special 
# integers between 1 and $n.
##
use boolean;  
sub is_special{
    my($x) = @_;
    my %h; 
    my @digits = split(//, $x);
    map{ $h{$_} = undef } @digits; 
    return keys %h == @digits; 
}

MAIN:{
    say q// . grep{ is_special($_) } 1 .. $ARGV[0];  
}
