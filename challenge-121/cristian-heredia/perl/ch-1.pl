=begin
    TASK #1 › Invert Bit
    Submitted by: Mohammad S Anwar
    You are given integers 0 <= $m <= 255 and 1 <= $n <= 8.

    Write a script to invert $n bit from the end of the binary representation of $m and print the decimal representation of the new binary number.

    Example
    Input: $m = 12, $n = 3
    Output: 8

    Binary representation of $m = 00001100
    Invert 3rd bit from the end = 00001000
    Decimal equivalent of 00001000 = 8

    Input $m = 18, $n = 4
    Output: 26

    Binary representation of $m = 00010010
    Invert 4th bit from the end = 00011010
    Decimal equivalent of 00011010 = 26
=end
=cut 

use strict;
use warnings;
use Data::Dumper;

my $m = 18;
my $n = 4;

# Convert to binary
my @bits = split(//, sprintf ("%b", $m));

#Complete with 0
my $counter = 8-@bits;
while ($counter!=0){
    unshift @bits, '0';
    $counter--;
}

# invert $n bit from the end of the binary
if($bits[8-$n]==0){
   $bits[8-$n]='1'; 
}
else{
   $bits[8-$n]='0'; 
}
# Convert to string
my $newNumber = join( '', @bits );
# Convert to decimal
my $result = eval("0b$newNumber");

print("Output: $result");
