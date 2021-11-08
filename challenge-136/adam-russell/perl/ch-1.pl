use strict;
use warnings;
##
# You are given 2 positive numbers, $m and $n.
# Write a script to find out if the given two numbers are Two Friendly.
##
use POSIX;
use boolean;

sub euclid {
    my($a, $b) = @_;
    return ($b) ? euclid($b, $a % $b) : $a;
}

sub two_friendly{
    my($m, $n) = @_;
    my $gcd = euclid($m, $n);
    my $p = log($gcd) / log(2);
    return boolean(ceil($p) == floor($p));
}

MAIN:{
    print two_friendly(8, 24). "\n";
    print two_friendly(26, 39). "\n";
    print two_friendly(4, 10). "\n";
}