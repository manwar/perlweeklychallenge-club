#!/usr/bin/env -S perl -wl

use strict;

print &range_list(1,3,4,5,7); #([3,5])
print &range_list(1,2,3,6,7,9); #([1,3],[6,7])
print &range_list(0,1,2,4,5,6,8,9); #([0,2],[4,6],[8,9])

sub range_list {
    my @arry = sort {$a <=> $b} @_;
    
    unshift @arry, -1_000_000;
    push @arry, 1_000_000;

    my @indices = grep {
        ($arry[$_]-$arry[$_-1]==1) ||
        ($arry[$_+1]-$arry[$_]==1)                
    } (1 .. @arry-2);
    
    &print_edges( @arry [ @indices] );   
}

sub print_edges {
    my @ranges = @_;
    my $return_string = '(['. $ranges[0] . ','; 

    for my $i (1 .. @ranges-1) {
        ( ($ranges[$i] - $ranges[$i-1]) > 1 ) && 
            ($return_string .= ($ranges[$i-1] . "],[" . $ranges[$i] . ","));
        ( $i == @ranges-1 ) && 
            ($return_string .= ($ranges[$i] . "])"))
    }
    $return_string;   
}
