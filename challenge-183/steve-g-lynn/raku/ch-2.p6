#!/usr/bin/env perl6

#real	0m0.395s
#user	0m0.531s
#sys	0m0.056s


print "Example 1: ",diff_in_y_d( '2019-02-10','2022-11-01');
print "Example 2: ",diff_in_y_d( '2020-09-15','2022-03-29');
print "Example 3: ",diff_in_y_d( '2019-12-31','2020-01-01');
print "Example 4: ",diff_in_y_d( '2019-12-01','2019-12-31');
print "Example 5: ",diff_in_y_d( '2019-12-31','2020-12-31');
print "Example 6: ",diff_in_y_d( '2019-12-31','2021-12-31');
print "Example 7: ",diff_in_y_d( '2020-09-15','2021-09-16');
print "Example 8: ",diff_in_y_d( '2019-09-15','2021-09-16');

#Example 1: 3 year(s), 264 day(s)
#Example 2: 1 year(s), 195 day(s)
#Example 3: 0 year(s), 1 day(s)
#Example 4: 0 year(s), 30 day(s)
#Example 5: 1 year(s), 0 day(s)
#Example 6: 2 year(s), 0 day(s)
#Example 7: 1 year(s), 1 day(s)
#Example 8: 2 year(s), 1 day(s)


sub diff_in_y_d ($datestr1, $datestr2) {
    my @datestr1 = $datestr1.split('-');
    my @datestr2 = $datestr2.split('-');
    
    my $years;
    if (Int(@datestr2[1]) >= Int(@datestr1[1])) {
        $years = @datestr2[0] - @datestr1[0];
    } 
    else {
        $years = @datestr2[0] - @datestr1[0] - 1;
        @datestr2[0]-=1;
    }        
    
    my $days = Date($datestr2)-Date(@datestr2[0] ~ '-' ~ @datestr1[1] ~ '-' ~ @datestr1[2]);
    
    return "$years year(s), $days day(s)\n";
}
