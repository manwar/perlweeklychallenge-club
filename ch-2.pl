#!/usr/bin/perl
use strict;
use Test::Simple tests => 2;
use List::Util qw/max sum/;

#reference: https://www.tutorialspoint.com/perl/bitwise_operators_example.htm


sub f {  # compare two bit-strings by xor
    my $hint = ($_[0] ^ $_[1]) ;
    my $ans = sum (split //, sprintf("%b", $hint));
    return $ans;  
}

# first parameter: number of terms; remaining: terms in the list
sub conclude {
    my ($N, @val) = @_; 
    my $sum = 0;
    for my $i (0..$N-2) {
       for my $j ($i+1..$N-1) {
          $sum += f($val[$i], $val[$j]); 
       }
    }
    return $sum; 
}


ok (conclude(3,2,3,4) == 6), "bad";
ok (conclude(2,1,3)==1), "too bad";


