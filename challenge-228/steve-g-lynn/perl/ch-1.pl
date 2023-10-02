#!/usr/bin/env -S perl -wl


print &unique_sum(2,1,3,2); #4
print &unique_sum(1,1,1,1); #0
print &unique_sum(2,1,3,4); #10

sub unique_sum {
    my @int = @_;
    
    #-- %int : hash to count frequency of each element of @int,
    #-- $retval : return value 
    my (%int, $retval); 
    
    #initialize %int values, $retval, to zero
    $retval=0;
    map {$int{$_}=0} @int; 
    
    #-- loop thru' @int counting frequencies and updating $retval
    map {
        $int{$_}++;
        
        ($int{$_} > 1) ?
            ( ($int{$_} == 2)  ? ($retval -= $_) : 1 ) 
            : ($retval += $_);  
    }  @int;
    $retval;
}


