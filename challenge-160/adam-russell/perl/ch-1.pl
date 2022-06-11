use strict;
use warnings;
##
# You are given a positive number, $n < 10.
# Write a script to generate english text sequence starting with the English cardinal 
# representation of the given number, the word ‘is’ and then the English cardinal 
# representation of the count of characters that made up the first word, followed by a 
# comma. Continue until you reach four.
##
my %cardinals = (
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine"
);

sub four_is_magic{
    my($n, $s) = @_;
    $s = "" if !$s;
    return $s .= "four is magic" if $n == 4;
    $s .= $cardinals{$n} . " is " . $cardinals{length($cardinals{$n})} . ", ";
    four_is_magic(length($cardinals{$n}), $s);
}

MAIN:{
    print four_is_magic(5) . "\n";
    print four_is_magic(7) . "\n";
    print four_is_magic(6) . "\n";
}