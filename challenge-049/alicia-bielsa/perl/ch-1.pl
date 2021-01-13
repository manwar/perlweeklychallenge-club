
#Smallest Multiple

#Write a script to accept a positive number as command line argument and print the smallest multiple of the given number consists of digits 0 and 1.

#For example:
#For given number 55, the smallest multiple is 110 consisting of digits 0 and 1.
use strict;
use warnings;
unless (scalar(@ARGV) == 1 ){
    die "ERROR: Incorrect number of arguments. Only one argument expected\n";
}

my $numberInput = $ARGV[0];
unless ($numberInput =~ /^[0-9]+$/){
    die "ERROR: Not a positive number '$numberInput'\n";
}

my $smallestMultiple = 0;
my $count = 1;

while ($smallestMultiple == 0 ){
    $smallestMultiple = ( $numberInput * $count ) =~ /^[01]+$/ ? ( $numberInput * $count) : 0;
    $count++;
}
print "$smallestMultiple\n"