#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

# Given cases (some bases...)
my @bases = ( 2, 4, 10, 12 );
my $base;

# If you have some time on your hands, why not try
# them all?
# @bases = 2 .. 36;

print("\n");
foreach $base (@bases){
    printf(
        "    f(%d)=\"%s\"\n",
        $base,
        calculate_largest_non_repeating_square_in_base($base)
    );
}
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the largest perfect square that does not contain a repeated digit
# in a specified base
# Takes one argument:
# * The specified base, which must range from 2 to 36, inclusive (e.g. 16)
# Returns on success:
# * A string representing the largest square with no repeated digits when
#   expressed in the specified base (e.g. "FEB6795D4C32A801")
# Returns on error:
# * undef if the base is out of range
# * An empty string if there did not appear to be any squares without repeating
#   digits in the specified base
################################################################################
sub calculate_largest_non_repeating_square_in_base{
    my $base = int(shift());

    return(undef)
        if(($base < 2) || ($base > 36));

    my $digit_string = "ZYXWVUTSRQPONMLKJIHGFEDCBA9876543210";
    my $root;

    # Grab all the possible digits in this base- which
    # also happens (actually this is not a
    # coincidence...) to be the largest number in this
    # base with no repeating digits
    $digit_string = substr($digit_string, -$base);

    # Get the root of the largest square less than
    # the aforementioned number
    $root = int(sqrt(digit_string_to_number($digit_string, $base)));

    # Loop while the root is not zero and the square,
    # when expressed in the specified base, has a
    # repeating digit
    while(
        $root
        &&
        (
            # Assignment to capture digit string is deliberate
            ($digit_string = number_to_digit_string($root ** 2, $base))
            =~
            m/(.).{0,}\1/
        )
    ){
        # Decrement the root
        $root--;
    }

    if($root){
        # Root is not zero- return the square in the
        # specified base 
        return($digit_string);
    } else{
        # Root is zero- return an empty string
        return("");
    }

}



################################################################################
# Convert a string of digits in a specified base from 2 to 36 into its
# computer-friendly numerical representation
# Takes two arguments:
# * The string of digits, which must consist solely of digits 0-9 and A-Z (e.g.
#   "FF"); only those digits valid for the specified base (e.g. 0-F will be
#   accepted 
# * The base in which the number in the string is written, which must range
#   from 2 to 36, inclusive (e.g. 16)
# Returns on success:
# * The numerical representation of the number encoded in the string (e.g. 255)
# Returns on error:
# * undef if the base is out of range or there are invalid digits in the string
#   for the defined base
################################################################################
sub digit_string_to_number{
    my $string = shift();
    my $base = int(shift());

    return(undef)
        if(($base < 2) || ($base > 36));

    my %digit_table = (
        0 =>  0,  1 =>  1,  2 =>  2,  3 =>  3,  4 =>  4,
        5 =>  5,  6 =>  6,  7 =>  7,  8 =>  8,  9 =>  9,
        A => 10,  B => 11,  C => 12,  D => 13,  E => 14,
        F => 15,  G => 16,  H => 17,  I => 18,  J => 19,
        K => 20,  L => 21,  M => 22,  N => 23,  O => 24,
        P => 25,  Q => 26,  R => 27,  S => 28,  T => 29,
        U => 30,  V => 31,  W => 32,  X => 33,  Y => 34,
        Z => 35
    );
    my @digits;
    my $i = 0;
    my $total = 0;

    # Reverse the digits so the least-significant
    # comes first, allowing their array indices to be
    # used as exponents
    @digits = reverse(split('', uc($string)));

    # Repeatedly accumulate each digit- if it's valid-
    # by adding its value raised to the power of its
    # position within the number
    for($i=0; $i<scalar(@digits); $i++){
        return(undef)
            unless(
                defined($digit_table{$digits[$i]})
                &&
                ($digit_table{$digits[$i]} < $base)
            );

        $total += ($base ** $i) * $digit_table{$digits[$i]};
    }

    return($total);

}



################################################################################
# Convert a computer-friendly number into a string of digits in a specified
# base from 2 to 36
# Takes two arguments:
# * The number to convert to a string of digits (e.g. 255)
# * The base in which the number should be written, which must range from 2 to
#   32, inclusive (e.g. 16)
# Returns on success:
# * A string representing the number in the specified base (e.g. "FF")
# Returns on error:
# * undef if the base is out of range
################################################################################
sub number_to_digit_string{
    my $number = int(shift());
    my $base = int(shift());

    return(undef)
        if(($base < 2) || ($base > 36));

    my @digit_list = qw(
        0 1 2 3 4 5 6 7 8 9
        A B C D E F G H I J
        K L M N O P Q R S T
        U V W X Y Z
    );
    my $string = "";

    # Special case of the number being zero
    if($number == 0){
        return("0");
    }

    # Not zero- repeatedly convert remainders to
    # digits then truncate the dividend...
    while($number){
        $string = $digit_list[$number % $base] . $string;
        $number = int($number / $base);
    }

    return($string);

}



