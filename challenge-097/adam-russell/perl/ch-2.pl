use strict;
use warnings;
##
# You are given a binary string $B and an integer $S.
# Write a script to split the binary string $B of size $S 
# and then find the minimum number of flips required to make 
# it all the same.
use feature "bitwise";

sub substrings{
    my($d, $s) = @_;
    my @substrings;
    for(my $i = 0; $i < length($d); $i+=$s){
        push @substrings, substr($d, $i, $s);
    }    
    return @substrings;
}

sub min_flips{
    my($d, $s) = @_;
    my @flips;
    my @substrings = substrings($d, $s);
    for my $digits (@substrings){
        my $flip_count = 0;
        map { $flip_count += unpack("%32b*", $digits ^. $_) } @substrings;
        push @flips, $flip_count;
    }
    return [sort {$a <=> $b} @flips]->[0];
}

MAIN:{
    my($B, $S);
    $B = "101100101";
    $S = 3;
    print min_flips($B, $S) . " flips\n";
    $B = "10110111";
    $S = 4;
    print min_flips($B, $S) . " flips\n";
}