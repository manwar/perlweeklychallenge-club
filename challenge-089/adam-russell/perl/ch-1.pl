use strict;
use warnings;
##
# You are given a positive integer $N. Write a script to sum GCD of all possible 
# unique pairs between 1 and $N.
##

sub all_unique_pairs{
    my($n) = @_;
    my %pairs;
    for my $i (1 .. $n){
        for my $j (1 .. $n){
            $pairs{"$i-$j"} = -1 unless $pairs{"$i-$j"} || $pairs{"$j-$i"} || $i == $j; 
        }
    }
    return sort keys %pairs;
}

sub euclid {
    my($a, $b) = @_;
    return ($b) ? euclid($b, $a % $b) : $a;
}

MAIN:{
    my $gcd_sum = 0; 
    my @values =  all_unique_pairs(3);
    for my $pair (@values[0 .. @values - 2]){
        my($i, $j) = split(/-/, $pair);
        $gcd_sum += euclid($i, $j);
        print "gcd($i, $j) + ";  
    }
    my ($i, $j) = split(/-/, $values[-1]); 
    $gcd_sum += euclid($i, $j);
    print "gcd($i, $j) = $gcd_sum\n";  

    $gcd_sum = 0; 
    @values =  all_unique_pairs(4);
    for my $pair (@values[0 .. @values - 2]){
        my($i, $j) = split(/-/, $pair);
        $gcd_sum += euclid($i, $j);
        print "gcd($i, $j) + ";  
    }
    ($i, $j) = split(/-/, $values[-1]); 
    $gcd_sum += euclid($i, $j);
    print "gcd($i, $j) = $gcd_sum\n";  
}