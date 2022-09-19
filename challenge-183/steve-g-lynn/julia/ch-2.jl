#!/usr/bin/env julia

#real	0m0.854s
#user	0m0.932s
#sys	0m0.408s

using Dates

function diff_in_y_d( date1::Date, date2::Date ) ::String
    if month(date2) >= month(date1)
        years=year(date2)-year(date1)
        myyr=year(date2)
    else 
        years=year(date2)-year(date1)-1
        myyr=year(date2)-1
    end
    days = date2-Date(myyr,month(date1),day(date1))
    return "$years year(s) $days"
end

println( "Example 1: ",diff_in_y_d( Date("2019-02-10"), Date("2022-11-01") ) )

println( "Example 2: ",diff_in_y_d( 
    Date("2020-09-15"),
    Date("2022-03-29")));

println("Example 3: ",diff_in_y_d(
    Date("2019-12-31"),
    Date("2020-01-01")));
    
println("Example 4: ",
    diff_in_y_d( Date("2019-12-01"), Date("2019-12-31") ) );

println("Example 5: ",
    diff_in_y_d( Date("2019-12-31"),Date("2020-12-31") ) );
    
println("Example 6: ",
    diff_in_y_d( Date("2019-12-31"), Date("2021-12-31") ) );
    
println("Example 7: ",
    diff_in_y_d( Date("2020-09-15"), Date("2021-09-16") ) );
    
println("Example 8: ",
    diff_in_y_d( Date("2019-09-15"),Date("2021-09-16") ) );


#Example 1: 3 year(s) 264 days
#Example 2: 1 year(s) 195 days
#Example 3: 0 year(s) 1 day
#Example 4: 0 year(s) 30 days
#Example 5: 1 year(s) 0 days
#Example 6: 2 year(s) 0 days
#Example 7: 1 year(s) 1 day
#Example 8: 2 year(s) 1 day


