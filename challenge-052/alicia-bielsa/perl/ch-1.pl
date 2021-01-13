use strict;
use warnings;

#Stepping Numbers

#Write a script to accept two numbers between 100 and 999. 
#It should then print all Stepping Numbers between them.

#    A number is called a stepping number if the adjacent digits have a difference of 1. 
#For example, 456 is a stepping number but 129 is not.


my $numberFrom = $ARGV[0];
my $numberTo = $ARGV[1];

unless ( isValidNumber($numberFrom) && isValidNumber($numberTo) ) {
    die "Error: Scripts accepts two numbers between 100 and 999\n";
}

#From should be smaller than to, else we swap
if ($numberFrom > $numberTo ){
    my $tmp = $numberFrom;
    $numberFrom = $numberTo;
    $numberTo = $tmp;
}

foreach my $number ($numberFrom..$numberTo) {
    my @aDigits = split('', $number);
    my $isSteppingNumber = 1;
    foreach my $i (1..$#aDigits){
        my $diff = $aDigits[$i] - $aDigits[$i-1];
        if ( $diff != 1 && $diff != -1 ){
            $isSteppingNumber = 0;
        }
    }
    if ($isSteppingNumber){
        print "$number\n";
    }
}


sub isValidNumber {
    my $number = shift;
    if ( defined($number) && $number >= 100 &&  $number <= 999 ) {
        return 1;
    }
    return 0;
}