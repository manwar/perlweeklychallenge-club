#!perl.exe

use strict;
use warnings;

use IO::Prompter;
use Data::Types qw(is_int);

### Author: Robert DiCicco
### Date: 9-NOV-2021
### Challenge #: 138  Split_Number.pl

# limit input to 2,3, and 4 digit numbers

my $DEBUG = 0;

my $number = prompt 'Input number: ', -integer => [10..9999];
$number = int($number);
my $root = sqrt($number);

print("Square Root = $root\n");

if (! is_int($root)){
    die "Square Root $root is not an integer\n";
}

my @array = split (//, $number);
my $numdigits = scalar(@array);

if($numdigits == 2){
    my $val = int($array[0]) + int($array[1]);
    if ($val == $root){
        print("$array[0] + $array[1] = $val\n");
    }
    else {
        print("$array[0] + $array[1] != sqrt\($number\)\n");
    }
}

if($numdigits == 3){
    # sum of each of the digits
    my $val = int($array[0]) + int($array[1]) + int($array[2]);
    if ($val == $root){
        print("$array[0] + $array[1] + $array[2] = $val\n");
    }

    # first two digits (number from 10 - 99) , plus last digit
    $val = (int($array[0]) * 10 + (int($array[1])) + int($array[2]));
    if($val == $root){
        print("$array[0]$array[1] + $array[2] = $val\n");
    }

    # first digit, plus last two digits ( number from 10 - 99)
    $val = int($array[0])+ (int($array[1]) * 10 ) + int($array[2]);
    if($val == $root){
        print("$array[0] + $array[1]$array[2] = $val\n");
    }
}
elsif ($numdigits == 4){
    # sum of first two digits as number (10 - 99), plus digit 3, + digit 4
    my $val = (int($array[0]) * 10 + (int($array[1]) *  1)) + int($array[2])  + int($array[3]);
    if($val == $root){
        print("$array[0]$array[1] + $array[2] + $array[3] = $val\n");
    }

    if ($DEBUG){print("$array[0]$array[1] + $array[2] + $array[3] = $val\n")}

    # sum of digit 1 * 100, + digit 2 * 10 + digits 3 + digit 4
    $val = (int($array[0]) * 100+ (int($array[1]) *  10)) + int($array[2])  + int($array[3]);

    if($val == $root){
        print("$array[0]$array[1]$array[2] + $array[3] = $val\n");
    }

    if ($DEBUG){print("$array[0]$array[1]$array[2] + $array[3] = $val\n")}

    # sum of digit 1, digit 2 * 100, digit 3 * 10, + digit 4

    $val = (int($array[0]) + (int($array[1]) *  100)) + int($array[2]) * 10 + int($array[3]);

    if($val == $root){
        print("$array[0] + $array[1]$array[2]$array[3] = $val\n");
    }

    if ($DEBUG){print("$array[0] + $array[1]$array[2]$array[3] = $val\n")}

    # sum of digit 1, + digit 2 * 10, + digits 3 and 4
    $val = (int($array[0]) + (int($array[1]) *  10)) + int($array[2]) + int($array[3]);
    if($val == $root){
        print("$array[0] + $array[1]$array[2] + $array[3] = $val\n");
    }

    if($DEBUG){print("$array[0] + $array[1]$array[2] + $array[3] = $val\n")}

    # sum of digit 1, digit 2, digit 3 * 10, + digit 4

    $val = int($array[0]) + int($array[1]) + (int($array[2]) * 10) + int($array[3]);

    if($val == $root){
        print("$array[0] + $array[1] + $array[2]$array[3] = $val\n");
    }

    if ($DEBUG){print("$array[0] + $array[1] + $array[2]$array[3] = $val\n")}

    # sum of individual digits

    $val = int($array[0]) + int($array[1]) + int($array[2]) + int($array[3]);

    if($val == $root){
        print("$array[0] + $array[1] + $array[2] + $array[3] = $val\n");
    }

    if ($DEBUG){print("$array[0] + $array[1] + $array[2] + $array[3] = $val\n")}
}
