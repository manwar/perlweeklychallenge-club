use v5.36;
use strict;
use warnings;
##
# You are given an integer, 0 < $n <= 15.
# Write a script to find the number of orderings of numbers that form a cute list.
##  
use Hash::MultiKey;

sub cute_list{
    my($n) = @_;
    my %cute;
    tie %cute, "Hash::MultiKey";
    for my $i (1 .. $n){
        $cute{[$i]} = undef;
    }
    my $i = 1;
    {
        $i++;
        my %cute_temp;
        tie %cute_temp, "Hash::MultiKey";
        for my $j (1 .. $n){
            for my $cute (keys %cute){
                if(0 == grep {$j == $_} @{$cute}){
                    if(0 == $j % $i || 0 == $i % $j){
                        $cute_temp{[@{$cute}, $j]} = undef;
                    }    
                }
            }
        }
        %cute = %cute_temp;
        untie %cute_temp;
        redo unless $i == $n;
    }
    return keys %cute;
}

MAIN:{
    say cute_list(15) . q//;
}