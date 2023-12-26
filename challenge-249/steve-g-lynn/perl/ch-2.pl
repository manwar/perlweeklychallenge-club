#!/usr/bin/env -S perl -wl

local *DI_string_match = sub {
    my $str = $_[0];
    
    #-- return 0 (error) if input is not D or I only
    ($str =~ /^[DI]+$/) || (return 0);

    #-- create sorted array of indices from which to generate output
    my @tmp=(0 .. length($str));
    
    #-- loop through $str indices, 
    # if a position i is 'D' pop @tmp (highest item) and assign to retval[i]
    # if a position i is 'I' shift @tmp (lowest item) and assign to retval[i]

    my @retval = (); #-- return value
    map {
        (substr($str,$_,1) eq 'D') && ($retval[$_] = pop @tmp);
        (substr($str,$_,1) eq 'I') && ($retval[$_] = shift @tmp);
    }
    0 .. length($str)-1;
    $retval[length($str)] = shift @tmp; #-- last item left
    @retval;
};

print join ',',  &DI_string_match('IDID'); #0,4,1,3,2
print join ',',  &DI_string_match('III'); #0,1,2,3
print join ',',  &DI_string_match('DDI'); #3,2,0,1

1;
