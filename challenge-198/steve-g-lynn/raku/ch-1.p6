#!/usr/bin/env perl6


say &max-gap([2,5,8,1]); #2
say &max-gap([3]); #0

sub max-gap (@list) {
    my (@sorted_list) = @list.sort( {$^a <=> $^b} );
    (@list.elems <= 2) && (return 0);
    my %gaps;
        
    (0 .. @list-2).map( {%gaps{@list[$_+1]-@list[$_]}++} );
    
    
    %gaps{ ( (%gaps.keys).sort( {$^b <=> $^a} ))[0] };
}
