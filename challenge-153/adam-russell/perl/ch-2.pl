use strict;
use warnings;
##
# Write a script to figure out if the given integer is a factorion.
##
use boolean;

sub factorial{
    my($n) = @_;
    return 1 if $n == 1;
    $n * factorial($n - 1);
}

sub is_factorion{
    my($n) = @_;
    return boolean($n == unpack("%32I*", pack("I*", map {factorial($_)} split(//, $n))));
}

MAIN:{
    print is_factorion(145) . "\n";
    print is_factorion(123) . "\n";
}