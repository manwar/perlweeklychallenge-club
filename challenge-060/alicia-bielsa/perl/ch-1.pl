use strict;
use warnings;

#TASK #1 › Excel Column
#Reviewed by: Ryan Thompson

#Write a script that accepts a number and returns the Excel Column Name it represents and vice-versa.

#Excel columns start at A and increase lexicographically using the 26 letters of the English alphabet, A..Z. 
#After Z, the columns pick up an extra “digit”, going from AA, AB, etc., 
#which could (in theory) continue to an arbitrary number of digits. In practice, Excel sheets are limited to 16,384 columns.
#Example

#Input Number: 28
#Output: AB

#Input Column Name: AD
#Output: 30

my %hIndexLetters = ( 1=> 'A', 2=> 'B', 3=> 'C', 4 => 'D', 5 => 'E', 6=> 'F', 7=> 'G', 8 => 'H',
                    9 => 'I', 10=> 'J', 11=> 'K', 12 => 'L', 13 => 'M', 14 => 'N', 15 => 'O', 16 => 'P',
                    17 => 'Q', 18=> 'R', 19=> 'S', 20 => 'T',21 => 'U', 22=> 'V', 23=> 'W', 24 => 'X',
                    25 => 'Y', 26=> 'Z');
my %hLetterIndex = reverse(%hIndexLetters );
my $totalLetters = scalar keys %hIndexLetters ;

my $input = $ARGV[0];
if (!defined($input)  ){
    die "Error: This script accepts a positive number or letters only\n";
}

my $output ='';
if ($input =~  /^\d+$/ && $input > 0){
    $output = numberToLetters($input);
} elsif ($input =~  /^[A-Z]+$/){
    $output = lettersToNumber($input);
} else {
   die "Error: Input  $input Incorrect This script accepts a  positive number or letters only\n";
}

print "$input = $output\n";



sub lettersToNumber {
    my $letters = shift;
    my @aLettersInput = split('',$letters);
    my $number= 0;
    my $base = 0;
    foreach my $letter (reverse(@aLettersInput)){
        $number += $hLetterIndex{$letter} * $totalLetters ** $base  ;
        $base ++;
    }
    return $number;
}

sub numberToLetters {
    my $number = shift;

    my $letters;
    while ($number  > 0 ) {
        my $remainder = $number % $totalLetters ;
        my $divResult = int($number / $totalLetters) ;
        $letters .= $hIndexLetters{$remainder};
        if ($divResult == 0){
           $number = 0;
        } else {
           $number = $divResult ;
        }
    }
    return reverse($letters);
}




