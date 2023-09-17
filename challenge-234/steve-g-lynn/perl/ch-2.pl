#!/usr/bin/env -S perl -wl

#-- sticking to perl 4 syntax


print &unequal_triplets(4,4,2,4,3); #3
print &unequal_triplets(1,1,1,1,1); #0
print &unequal_triplets(4,7,1,10,7,4,1,1); #28

sub unequal_triplets {
    local (%unequal_triplets, $unequal_triplets);
    foreach (@_) {
        #-- input validation: only positive integers allowed
        ($_ > 0) || (die "Only positive integers allowed.");
        
        #-- count the frequency
        $unequal_triplets{$_}++;
    }
    
    local ($i, $j, $k); #-- counters 
    
    (scalar(keys(%unequal_triplets))<3) && (return 0);
    #-- use parentheses so we don't have to worry about precedence
    
    local $unequal_triplets=0; #-- return value
    
    #-- loop through the unique elements
    #-- 3 nested loops to enumerate triplets
    
    I: foreach $i (keys %unequal_triplets){
        J: foreach $j (keys %unequal_triplets){
            ($i==$j) && (next I);
            K: foreach $k (keys %unequal_triplets){
                ( ($k==$j) || ($k==$i) ) && (next J);
                
                #-- add product of frequencies of elements i, j and k
                $unequal_triplets += $unequal_triplets{$i}*
                    $unequal_triplets{$j}*
                    $unequal_triplets{$k};
            } 
        }
    }
    $unequal_triplets;     
}


