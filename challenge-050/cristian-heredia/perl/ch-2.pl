use strict;
use warnings;

#Noble Integer 
#  You are given a list, @L,
#  of three or more random integers between 1 and 50. A Noble Integer is an integer N in @ L,
#  such that there are exactly N integers greater than N in @ L.
#  Output any Noble Integer found in @ L, or an empty list if none were found. 
# 
#An interesting question is whether or not there can be multiple Noble Integers in a list. 
# 
#For example,
#
#Suppose we have list of 4 integers[2, 6, 1, 3]
# 
#Here we have 2 in the above list, known as Noble Integer, since there are exactly 2 integers in the list i.e. 3 and 6, which are greater than 2. 
# 
#Therefore the script would print 2.

my $sizeArray = 4;
my @array;
my $start = 1;
my $end = 50;
my $random_number;
my $total = 0;
my $result = '';

createArray();
analizeArray();

sub createArray {

    for (my $i=0; $i<$sizeArray; $i++) {
        $random_number = $start + int rand ($end - $start + 1);
        $array[$i] = $random_number;
    }
    
    print "@array\n";
}

sub analizeArray {
    
    for (my $j=0; $j<$sizeArray; $j++) {
        
        for (my $k=0; $k<$sizeArray; $k++) {
            if ($j == $k) {
             }
            elsif ($array[$j] < $array[$k]) {
                $total++;
            }
        }
        
        if ($total eq $array[$j] ) {
           $result = $result."$array[$j] "; 
        }
        $total = 0;
    }

    resultMessage();   
}

sub resultMessage {
    if ($result eq '') {
        print "There isn't any result\n";
    }
    else {
        print "The final result: $result\n";
    }
}
