use strict;
use warnings;
##
# Write a script that takes 2 or more strings as command line 
# parameters and print the longest common substring.
##
use SuffixArray; 

sub lcp{
    my($s, $p, $t, $q) = @_;
    my @s = split(//, $s); 
    my @t = split(//, $t); 
    my $n = length($s) - $p < length($t) - $q ? length($s) - $p : length($t) - $q;
    for my $i (0 .. $n - 1){
        if($s[$p + $i] ne $t[$q + $i]){
            return substr($s, $p, $p + $i);  
        } 
    }  
    return substr($s, $p, $p + $n);  
} 

sub compare{
    my($s, $p, $t, $q) = @_;
    my @s = split(//, $s); 
    my @t = split(//, $t); 
    my $n = length($s) - $p < length($t) - $q ? length($s) - $p : length($t) - $q;
    for my $i (0 .. $n - 1){
        if($s[$p + $i] ne $t[$q + $i]){
            return ord($s[$p + $i]) - ord($t[$q + $i]);  
        }
    }
    return -1 if(length($s) - $p < length($t) - $q);
    return  1 if(length($s) - $p > length($t) - $q);
    return 0; 
}

sub lcs{
    my($s, $t) = @_;
    my $suffix_array0 = new SuffixArray(); 
    $suffix_array0->create($s); 
    my $suffix_array1 = new SuffixArray(); 
    $suffix_array1->create($t); 
    my $lcs = "";
    my($i, $j) = (0, 0);
    while($i < length($s) && $j < length($t)){
        my $p = $suffix_array0->index($i); 
        my $q = $suffix_array1->index($j); 
        my($x) = lcp($s, $p, $t, $q);
        if(length($x) > length($lcs)){
            $lcs = $x; 
        } 
        if(compare($s, $p, $t, $q) < 0){
            $i++; 
        } 
        else{
            $j++; 
        } 
    } 
    return $lcs;  
} 

MAIN:{
    my $string0 = $ARGV[0];
    my $string1 = $ARGV[1];
    my $lcs = lcs($string0, $string1);
    print "$lcs\n"; 
} 
