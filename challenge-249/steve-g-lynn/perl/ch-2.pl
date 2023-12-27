#!/usr/bin/env -S perl -wl

local *DI_string_match = sub {
    my $str = $_[0];
    
    #-- return 0 (error) if input is not D or I only
    ($str =~ /^[DI]+$/) || (return 0);

    #-- create mutable temp vars containing highest and lowest indices
    my ($lowest,$highest)=(0, length($str));
    
    #-- loop through $str indices, 
    # if str[i] is 'D', assign highest in output[i] and decrement it
    # if str[i] is 'I', assign lowest in output[i] and increment it

    my @retval = (); #-- return value
    map {
        (substr($str,$_,1) eq 'D') ?
        ($retval[$_] = $highest--) :
        ($retval[$_] = $lowest++);
    }
    0 .. length($str)-1;
    ($lowest==$highest) || die "Something wrong ...$!";
    $retval[length($str)] = $highest; #-- last item left
    @retval;
};

print join ',',  &DI_string_match('IDID'); #0,4,1,3,2
print join ',',  &DI_string_match('III'); #0,1,2,3
print join ',',  &DI_string_match('DDI'); #3,2,0,1

1;
