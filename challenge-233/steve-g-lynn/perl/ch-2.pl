#!/usr/bin/env -S perl -wl

#-- restricts to perl 4 syntax

&my_print( &frequency_sort( 1,1,2,2,2,3 ) ); #3 1 1 2 2 2
&my_print( &frequency_sort( 2,3,1,3,2 ) ); #1 3 3 2 2
&my_print( &frequency_sort(-1,1,-6,4,5,-6,1,4,1)); #5 -1 4 4 -6 -6 1 1 1


sub frequency_sort {
    local (%frequency_sort) = &my_freq( @_ );
    sort { 
        ($frequency_sort{$a} <=> $frequency_sort{$b} ) ||
        ($b <=> $a);
    } @_;
}

sub my_freq {
    #-- count frequencies
    local (%my_freq);
    map {$my_freq{$_}++} @_;
    %my_freq;
}

sub my_print {
    print "@_";
}

