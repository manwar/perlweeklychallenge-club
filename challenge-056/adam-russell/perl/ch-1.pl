use strict;
use warnings;
##
# You are given an array @N of positive 
# integers (sorted) and another non negative integer k.
# Write a script to find if there exists two indices 
# i and j such that A[i] - A[j] = k and i != j.
# Print the pairs of indices, if any such pairs exist.
my @N = (2, 7, 9);
my $k = 2;
my @pairs; 
for my $i (0 .. @N - 1){
    for my $j (0 .. @N - 1){
        push @pairs, [$i, $j] if($N[$i] - $N[$j] == $k && $i != $j);  
    }
}
if(!@pairs){
    print "No matching pairs\n";     
}
elsif(@pairs == 1){
    print "Matching Pair: "; 
    print "(" . join(",", @{$pairs[0]}) . ")\n"; 
}
else{
    print "Matching Pairs: "; 
    for my $i (0 .. @pairs - 2){
        print "(" . join(",", @{$pairs[$i]}) . "), "; 
    }
    print "(" . join(",", @{$pairs[@pairs - 1]}) . ")\n"; 
}
