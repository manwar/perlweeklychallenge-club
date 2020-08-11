# Olympic Rings
# There are 5 rings in the Olympic Logo as shown below. They are color coded as in Blue, Black, Red, Yellow and Green.

# Olympic Rings

# We have allocated some numbers to these rings as below:

# Blue: 8
# Yellow: 7
# Green: 5
# Red: 9
# The Black ring is empty currently. You are given the numbers 1, 2, 3, 4 and 6. 
#Write a script to place these numbers in the rings so that the sum of numbers in each ring is exactly 11.

use strict;
use warnings;
use Data::Dumper;


my $TOTALSUM = 11;
my @aAvailableNumbers =(1, 2, 3, 4 ,6);

my %hColorValue = ('RED' => 9, 
                   'GREEN' => 5,
                   'YELLOW' => 7,
                   'BLUE' => 8,
                   'BLACK' => 0,
                   'RED_GREEN' => 0,
                   'GREEN_BLACK' => 0,
                   'BLUE_YELLOW' => 0,
                   'YELLOW_BLACK' => 0
);
my %hRingsComposition = (
                   'RED' =>  [ 'RED', 'RED_GREEN'],
                   'GREEN' =>  [ 'GREEN', 'RED_GREEN',  'GREEN_BLACK'],
                   'YELLOW' => [ 'YELLOW', 'BLUE_YELLOW', 'YELLOW_BLACK'],
                   'BLUE' => [ 'BLUE', 'BLUE_YELLOW'],
                   'BLACK' =>[ 'BLACK',  'GREEN_BLACK','YELLOW_BLACK']
);

my $countAvailableNumbers = scalar @aAvailableNumbers;
while ( $countAvailableNumbers ){
    foreach my $ringColor (keys %hRingsComposition){
       
        my $singleEmptyValue = findSingleEmptyValue($ringColor);
        if ($singleEmptyValue){
           
            my $currentRingSum = getCurrentRingSum($ringColor);   
            my $difference =  $TOTALSUM - $currentRingSum;
            if (checkValueAvailability($difference)){
                $hColorValue{$singleEmptyValue} =$difference;
            } else {
                die "ERROR: Value  '$difference' not available, imposible to resolve\n";
            }
        }       
    }
    $countAvailableNumbers = scalar @aAvailableNumbers;
}


#print Dumper (\%hColorValue);

foreach my $color (sort keys %hColorValue){
	print "$hColorValue{$color}\t\t$color\n";
}
sub findSingleEmptyValue {
    my $color = shift;
    my $countEmptyValues = 0;
    my $singleEmptyValue = '';
    foreach my $ringPart ( @{$hRingsComposition{$color}} ){
    # we need to find a case where only one value is 0 
        if ( $hColorValue{$ringPart}   ==  0   ) {
            $countEmptyValues++;
            $singleEmptyValue = $ringPart;
        }    
    }    
    if ($countEmptyValues == 1 ){
        return $singleEmptyValue;
    }
    return '';
}

sub getCurrentRingSum {
    my $color = shift;
    my $currentSum = 0;
    foreach my $ringPart ( @{$hRingsComposition{$color}} ){
        $currentSum += $hColorValue{$ringPart};
    }
    return $currentSum;
}

sub checkValueAvailability {
    my $valueToCheck = shift;
    foreach my $i (0..$#aAvailableNumbers){
        if ($aAvailableNumbers[$i]  == $valueToCheck){
            splice (@aAvailableNumbers, $i, 1);
            return 1;
        }        
    }
    return 0;
}


exit 0;