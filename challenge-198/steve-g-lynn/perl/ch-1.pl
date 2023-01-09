#!/usr/bin/env -S perl -wl

use strict;

print &max_gap(2,5,8,1); #2
print &max_gap(3); #0

sub max_gap {
    my (@list) = (sort {$a <=> $b} @_);
    (@list <= 2) && (return 0);
    my %gaps;
    
    map {$gaps{$list[$_+1]-$list[$_]}++}
    (0 .. @list-2);
        
    $gaps{ (sort {$b <=> $a} (keys %gaps))[0] };
}
