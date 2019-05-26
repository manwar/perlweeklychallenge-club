use strict;
use warnings;
##
# Write a script that finds the first square number that has at least 5 distinct digits.
##  
use boolean;
use constant X_0 => 100; 

sub is_distinct_five{
    my($n) = @_;
    my @digits = split(//, $n);
    my @unique_digits = keys %{{map {$_ => 1} @digits}};
    if(@unique_digits >= 5){
        return true;
    }
    return false; 
}


##
# Main
##
my $x = X_0 - 1;
my $found = false;
do{
    $x++;  
    $found = is_distinct_five($x**2);  
}until($found);  
print "First square with five distinct digits: ";
print $x**2 . " (= $x * $x)\n"; 
