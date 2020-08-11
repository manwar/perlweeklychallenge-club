use strict;
use warnings;
use Data::Dumper;


#TASK #2 › IPv4 Partition
#Reviewed by: Ryan Thompson

#You are given a string containing only digits (0..9). The string should have between 4 and 12 digits.

#Write a script to print every possible valid IPv4 address that can be made by partitioning the input string.

#For the purpose of this challenge, a valid IPv4 address consists of four “octets” i.e. A, B, C and D, separated by dots (.).

#Each octet must be between 0 and 255, and must not have any leading zeroes. (e.g., 0 is OK, but 01 is not.)
#Example

#Input: 25525511135,

#Output:

#255.255.11.135
#255.255.111.35

my $inputString = $ARGV[0];
unless (defined($inputString) && $inputString =~ /^\d{4,12}$/ ){
    die "Error: string containing only digits (0..9). The string should have between 4 and 12 digits.\n";
}
my $totalOctets=4 ;
my @aSubset = (3,2,1);
my @aOctets=();

searchOctets($inputString, '', $totalOctets);


sub searchOctets {
    my $input = shift;
    my $output = shift;
    my $level = shift;

    if ($level == 0  ){
        if ( $input eq ''){
           push(@aOctets , $output);
        }        
        return 0 ;
    } else {
        $level--;
    }
    
    foreach my $subset ( @aSubset ){
        if (length($input) < $subset ){
            next;
        }
        my $octet = substr($input, 0, $subset);
        if (isValidOctet($octet)){
            my $newinput = substr($input, $subset);
            my $newOutput = $output.$octet;
            if ($level != 0 ) {
                $newOutput .= '.';          
            }            
            searchOctets( $newinput,    $newOutput, $level);              
        }
    }
    return 0;
    
    
}

foreach my $octet (@aOctets){
    print "$octet\n";
    
    
}
sub isValidOctet {
    my $octetToCheck = shift;
    
    if ($octetToCheck =~ /^0\d+/){
        # No leading zeroes
        return 0;        
    }
    if (  $octetToCheck  >= 0 && $octetToCheck  <= 255){
        return 1;
    }
    return 0;
}


