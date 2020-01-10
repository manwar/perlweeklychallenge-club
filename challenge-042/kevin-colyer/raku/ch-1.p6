#!/usr/bin/perl6
use v6;

use Test;


=begin pod

TASK #1
Octal Number System
Write a script to print decimal number 0 to 50 in Octal Number System.

For example:

Decimal 0 = Octal 0
Decimal 1 = Octal 1
Decimal 2 = Octal 2
Decimal 3 = Octal 3
Decimal 4 = Octal 4
Decimal 5 = Octal 5
Decimal 6 = Octal 6
Decimal 7 = Octal 7
Decimal 8 = Octal 10
and so on.

=end pod

# Roll my own version because? Why not!
sub dec-to-oct(Int $n is copy) returns Str {
    return "0" if $n==0;
    my Str $o = "";
    while $n>0 {
        $o= $n +& 7 ~ $o; # add lower three bits
        $n= $n +> 3     ; # shift off lower three bits
    }
    return $o;
}

say "Decimal $_ = Octal {dec-to-oct($_)} is sprintf conversion {sprintf "%o", $_}" for ^51;
