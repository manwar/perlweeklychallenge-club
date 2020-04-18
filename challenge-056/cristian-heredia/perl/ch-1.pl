use strict;
use warnings;
use Data::Dumper;


#Diff-K
#You are given an array @N of positive integers (sorted) and another non negative integer k.
#Write a script to find if there exists 2 indices i and j such that A[i] - A[j] = k and i != j.
#It should print the pairs of indices, if any such pairs exist.
#
#Example:
#    @N = (2, 7, 9)
#    $k = 2
#Output : 2,1#

my @array;
my $k;

my @sortedArray;
my $length;
my $subtraction;
my $results = '';
my $number;
my $continue = 'N';


print "Please, provide a number for the array:\n";
obtainNumber();
requestArray();

sub requestArray {
    
    if ($number =~ /^\d+$/ ) {
        if ($continue ne 'Y') {
            push @array, $number;
        }
        print "Please provide another number\n";
        obtainNumber();
        
        if ($number =~ /^\d+$/) {
            push @array, $number;
            print "Do you want to continue introducing more numbers? Yes (Y) or No (N)\n";
            $continue = <>;
            $continue =~ s/^\s+|\s+$//g;
            
            if ($continue eq 'Y') {
                requestArray();
            }
            else {
                requestK();
            }
        }
        else {
            print "That's no correct, please provide another number.\n";
            obtainNumber();
            requestArray();
        }
    }
    else {
        print "That's no correct, please provide another number.\n";
        obtainNumber();
        requestArray();
    }
}

sub obtainNumber {
    
    $number = <>;
    $number =~ s/^\s+|\s+$//g;
}

sub requestK {
    
    print "Please provide a number for the comparison.\n";
    obtainNumber();
    if ($number =~ /^\d+$/) {
        $k = $number;
        sortArray();
    }
    else {
       print "That's no correct, please provide another number.\n";
       requestK(); 
    }
}

sub sortArray {
    
    @sortedArray = sort { $a <=> $b } @array;
    checkConditions();
}


sub checkConditions {
    
    $length = @sortedArray;
    foreach (my $i = 0; $i < $length; $i++) {

        foreach (my $j = 0; $j < $length; $j++) {

            if ($i != $j) {
                
                $subtraction = $sortedArray[$i] - $sortedArray[$j];

                if ($subtraction == $k) {
                    
                    $results = $results."$i, $j\n";
                }
            }
        }
    }
    printMessage();
}


sub printMessage {
    
    if ($results ne '') {
        print "The pairs of indices that meet that conditions are:\n$results";
    }
    else {
        print "There is not any indices that meet that conditions.\n";
    }
}
