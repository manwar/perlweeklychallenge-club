use strict;
use warnings;

#You are given a positive integer $N (<= 10).
#
#Write a script to print number of trailing zeroes in $N!.
#
#Example 1
#Input: $N = 10
#Output: 2 as $N! = 3628800 has 2 trailing zeroes
#
#Example 2
#Input: $N = 7
#Output: 1 as $N! = 5040 has 1 trailing zero
#
#Example 3
#Input: $N = 4
#Output: 0 as $N! = 24 has 0 trailing zero


#variables
my $N;
my $result = 1;
my $count = 0;
my $sentence;


requestNumber();

sub requestNumber {
   
    print "Please, introduce a number <= 10\n";
    $N = <>;
    $N =~ s/\s//g;
    if ($N =~ /^\d+$/ and $N <= 10) {
        obtainFactorial();
    }
    else {
        print "That's not a valid number\n";
        requestNumber();
    }
   
}

sub obtainFactorial {
   
    foreach (my $i = 2; $i <= $N; $i++){
       
        $result = $result * $i;
    }
    $sentence = "$N! = $result";
    trailingZeros();
}


sub trailingZeros {
   
    if ($result =~ /0$/) {
       
        chop($result);
        $count++;
        trailingZeros();
    }
    else {
        #Output
        print "$count as ".$sentence." has $count trailing zero\n";
    }
   
}
