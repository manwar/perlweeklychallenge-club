#!/usr/bin/env -S perl -wl

use PDL;
use PDL::NiceSlice;
use PDL::AutoLoader;

sub travel_expenditure {
    my ($ra_costs, $ra_days)=@_;
    my $costs=pdl $ra_costs;
    
    #-- input validation check that costs are reasonable
    #-- 7 day price is less than 7 * daily price
    #-- 7 day price is greater than daily price
 
    (scalar(@$ra_costs) == 3) || (die "bad costs");
    
    ( ($ra_costs->[1] < (7*$ra_costs->[0]))
        && ($ra_costs->[1] > $ra_costs->[0]) )
     || (die "bad costs");  

    #-- 30 day price is less than 30/7* 7-day price
    #-- 30 day price is greater than 7-day price
  
     ( ($ra_costs->[2] < (30/7*$ra_costs->[1]))
        && ($ra_costs->[2] > $ra_costs->[1]) )
     || (die "bad costs");  
  
    
    #-- input validation check that dates are in 0 .. 31
    (((pdl $ra_days)->flat->byte)->max > 31) && (die "bad date");
    (((pdl $ra_days)->flat->byte)->min < 1) && (die "bad date");
 
 
    #-- store days as a 31-element boolean 
    #-- with 1 at index corresponding to a travel day
    #-- and 0 at the index for non-travel days   
    my $days=zeros(31);
    $days(pdl($ra_days)-1).=1;
    
    #-- worth paying for a whole month?
    #-- check if # of days is greater than 30-day price / 7-day price * 7
    if ($days->sum > ($ra_costs->[2] / $ra_costs->[1] * 7)) {
        if ($days(0) & $days(30)) {
        #if both 1st and last day of 31-day month, then ..
            return $ra_costs->[2]+$ra_costs->[0];
            #cost is 30 days price + 1 day price
        }
        else {
            return $ra_costs->[2];
        }
    
    }
    my $weekly_card=0;
    my $days_paid_weekly=0;
    my $weekly_cutoff= int( $ra_costs->[1] / $ra_costs->[0] )+1;
    
    #-- cycle through $days looking for clusters of more than
    #-- 7-day price / 1-day price travel days in a 7-day stretch
    #-- (weekly cutoff days in a 7-day stretch)
    
    my $ctr=0;
    
    while ($ctr <= (30 - $weekly_cutoff)) {
    #-- slow interpreted loop is good enough
    #-- because the days vector won't scale beyond 31 days
        my $days_forward = (pdl (6, 30-$ctr) )->min;
        if ($days($ctr:($ctr+$days_forward))->sum >= $weekly_cutoff) {
            $weekly_card++;
            $days_paid_weekly += $days($ctr:($ctr+$days_forward))->sum;
            $ctr += $days_forward;
        }
        else {
            $ctr += 1;
        }
    }
    return $weekly_card*$costs(1)
        +( ($days->sum)-$days_paid_weekly ) * $costs(0);
}

print &travel_expenditure([2,7,25],[2..26,31]); #-- 25
print &travel_expenditure([2,7,25],[1,5,6,7,9,15]); #-- 11
print &travel_expenditure([2,7,25],[1..3,5,7,10..12, 14, 20, 30, 31]); #-- 20
