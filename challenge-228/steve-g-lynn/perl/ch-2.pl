#!/usr/bin/env -S perl -wl

print &empty_array(3,4,2); #5
print &empty_array(1,2,3); #3

sub empty_array {
    my @int=@_;
    my $retval=0; #-- return value
    
    #-- assuming unique ints
    #-- skipping input validation chores
    
    my %indx;
    #-- %indx: index of each element
 
    my @int_sorted = sort {$a <=> $b} @int;   
    
    while (scalar @int) {
        map {
            $indx{$int[$_]} = $_;     
        } 0 .. $#int;
    
        $retval += $indx{$int_sorted[0]} + 1;
    
        splice(@int,$indx{$int_sorted[0]},1);
        shift(@int_sorted);
    }
    
    $retval;
}


