#!/usr/bin/env -S perl -wl

#this script conforms to perl 4 syntax
#as specified in Programming perl 1st edition (the pink camel)

local *number_placement=sub {
    local ($count, @numbers)=@_;
    
    #-- helper sub-subs
    local *is_conformant = sub { #-- all inputs 0 or 1 ?
        local (@numbers) = @_;
        local $number;
        
        for $number (@numbers) { 
            ($number =~ /^0$/ || $number =~ /^1$/) || die "Non-conformant input";
        }
    }; 
    
    local *has_1_neighbor = sub {
        local ($indx)=@_;
        
        ( ($indx > 0) && ($numbers[$indx-1] =~ /^1$/) )
        || 
        ( ($indx < @numbers-1) && ($numbers[$indx+1] =~ /^1$/ ));
    };   
    
    #-- back to the main part of the subroutine
    &is_conformant( @numbers );
    
    local ($indx,$ctr);
    $ctr=0;
    
    for $indx (0 .. @numbers-1) {
        ( ($numbers[$indx] =~ /^0$/) && (!(&has_1_neighbor($indx))) )
        && ($ctr++);
        
        last if ($ctr >= $count); 
    }
    
    ($ctr >= $count) ? 1 : 0;
};

print &number_placement(1,1,0,0,0,1);
print &number_placement(2,1,0,0,0,1);
print &number_placement(3,1,0,0,0,0,0,0,0,1);

