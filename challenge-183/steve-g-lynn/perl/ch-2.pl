#!/usr/bin/env perl

#real	0m0.336s
#user	0m0.215s
#sys	0m0.128s

use Date::Manip;

print "Example 1: ",diff_in_y_d( '2019-02-10','2022-11-01');
print "Example 2: ",diff_in_y_d( '2020-09-15','2022-03-29');
print "Example 3: ",diff_in_y_d( '2019-12-31','2020-01-01');
print "Example 4: ",diff_in_y_d( '2019-12-01','2019-12-31');
print "Example 5: ",diff_in_y_d( '2019-12-31','2020-12-31');
print "Example 6: ",diff_in_y_d( '2019-12-31','2021-12-31');
print "Example 7: ",diff_in_y_d( '2020-09-15','2021-09-16');
print "Example 8: ",diff_in_y_d( '2019-09-15','2021-09-16');

#Example 1: 3 year(s) 264 day(s)
#Example 2: 1 year(s) 195 day(s)
#Example 3: 0 year(s) 1 day(s)
#Example 4: 0 year(s) 30 day(s)
#Example 5: 1 year(s) 0 day(s)
#Example 6: 2 year(s) 0 day(s)
#Example 7: 1 year(s) 1 day(s)
#Example 8: 2 year(s) 1 day(s)


sub diff_in_y_d {
    my ($datestr1,$datestr2)=@_;
    
    my $date1=Date::Manip::Date->new();
    my $date2=$date1->new_date();
    
    $date1->parse($datestr1);
    $date2->parse($datestr2);
    
    #-- first get an approx time difference in y:m:w:d format
    #-- 
    
    my $delta=$date1->calc($date2, "approx");
    my @yd=split(/,/,$delta->printf("%yv,%dMw,%dv"));

    #-- parses the time difference into a list giving 
    # years, full months and weeks expressed in days, remaining days
    #-- the latter two calculations are not exact enough

    #-- recalculate using the "semi-exact" approach
    #-- for the difference between date1+Y years and date 2
    #-- where Y years is the number of years from the first try

    $delta->parse("In ".$yd[0]." years");
    $date1=$date1->calc($delta);
    
    #-- date1 is now yd[0] years ahead of the original date1
    
    $delta=$date1->calc($date2,"semi");
    
    #-- "semi-exact" difference between new date1 and date2

    my @dd=split(/,/,$delta->printf("%yv,%dMw,%dv"));
    
    #-- as before split into years (should be 0), full months+weeks
    #-- counted in days, and remaining days    
    
    my $days=$dd[1]+$dd[2];
        
    #-- add up the two day fields to get the total number of days
    #-- for our output

    return $yd[0]," year(s) ",$days," day(s)\n";
}
