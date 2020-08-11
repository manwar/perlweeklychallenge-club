use strict;
use warnings;

my $number = 200;
my $result;
my @array;

push @array, $number; 
do {  
    if ($number%2){
    $result = $number-1;
    push @array, $result;
    $number = $result/2;
    push @array, $number;
    } else {
    $number = $number/2;
    push @array, $number;
    }
}while($number > 1);
    @array = reverse@array;
    print "@array\n";
