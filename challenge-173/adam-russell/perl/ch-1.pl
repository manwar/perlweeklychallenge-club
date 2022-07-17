use strict;
use warnings;
##
# You are given a positive integer, $n.
# Write a script to find out if the given number is Esthetic Number.
##
use boolean;

sub is_esthetic{
    my($n) = @_;
    my @digits = split(//, $n);
    my $d0 = pop @digits;
    while(@digits){
        my $d1 = pop @digits;
        return false if abs($d1 - $d0) != 1;
        $d0 = $d1;
    }
    return true;
}

MAIN:{
    my $n;
    $n = 5456;
    print "$n is ";
    print "esthetic\n" if is_esthetic($n);
    print "not esthetic\n" if !is_esthetic($n);
    $n = 120; 
    print "$n is ";
    print "esthetic\n" if is_esthetic($n);
    print "not esthetic\n" if !is_esthetic($n);
}
