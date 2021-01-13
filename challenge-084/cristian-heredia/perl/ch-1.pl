=begin
    TASK #1 › Reverse Integer
    Submitted by: Mohammad S Anwar
    You are given an integer $N.
    
    Write a script to reverse the given integer and print the result. Print 0 if the result doesn't fit in 32-bit signed integer.
    
    The number 2,147,483,647 is the maximum positive value for a 32-bit signed binary integer in computing.
    
    Example 1:
    Input: 1234
    Output: 4321
    Example 2:
    Input: -1234
    Output: -4321
    Example 3:
    Input: 1231230512
    Output: 0
=end
=cut

use warnings;
use strict;
use Data::Dumper;

my $N =  '-1234';
my $number;
my @array;
my @result;
my $reverse = '';
my $flagNegative = 'N';

checkInteger($N);
reverseNumber();

sub checkInteger {
    
    $number = shift;
    if ($number <= -2147483648 or  $number >= 2147483647) {
        print "Output: 0\n";
        exit;
    }
    if ($reverse  ne '') {
            print"Output: $reverse\n";
    }
}

sub reverseNumber {
    
    @array = split //, $N;
    foreach (my $i =0; $i < @array; $i++) {
        if ($array[$i] eq '-') {
            $flagNegative = 'S';
        }
        else {
            unshift(@result, $array[$i]);
        }
    }
    if ($flagNegative eq 'S') {
        unshift(@result, '-'); 
    }
    $reverse = join( '', @result );
    checkInteger($reverse);
}

