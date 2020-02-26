use strict;
use warnings;
##
# A guest house had a policy that the light remain ON as 
# long as the at least one guest is in the house. There 
# is guest book which tracks all guest in/out time. 
# Write a script to find out how long in minutes the light were ON.
##
use DateTime;
use DateTime::Duration;
my $lights_on = new DateTime::Duration(
                    hours   => 0, 
                    minutes => 0,
                    seconds => 0   
);
my $start_time;  

while(my $line = <DATA>){
    chomp($line);
    my @fields = split(/:/, $line);
    my($in_hour, $in_minute, $out_hour, $out_minute) = @fields[1, 2, 3, 4];  
    $in_hour =~ tr/ //d;
    $in_minute =~ tr/ OUT//d;
    $out_hour =~ tr/ //d;
    if(!$start_time){
        $start_time = DateTime -> now(); 
        $start_time->set_hour($in_hour);  
        $start_time->set_minute($in_minute);  
        $start_time->set_second(0);  
    } 
    
    my $in = DateTime -> now();  
    $in->set_hour($in_hour);  
    $in->set_minute($in_minute);  
    $in->set_second(0);  
    my $out = DateTime -> now();  
    $out->set_hour($out_hour);  
    $out->set_minute($out_minute);  
    $out->set_second(0);  
    if(DateTime->compare($start_time, $in) <= 0){
        $lights_on -> add_duration($out->subtract_datetime($in));
    } 
    if(DateTime->compare($start_time, $in) > 0 && 
           DateTime->compare($start_time, $out) < 0
        ){
        $lights_on -> add_duration($out->subtract_datetime($start_time));
    } 
    $start_time = $out if (DateTime->compare($start_time, $out) < 0); 
} 
print $lights_on->hours() . " hours "; 
print $lights_on->minutes() . " minutes\n"; 

__DATA__
1) Alex    IN: 09:10 OUT: 09:45
2) Arnold  IN: 09:15 OUT: 09:33
3) Bob     IN: 09:22 OUT: 09:55
4) Charlie IN: 09:25 OUT: 10:05
5) Steve   IN: 09:33 OUT: 10:01
6) Roger   IN: 09:44 OUT: 10:12
7) David   IN: 09:57 OUT: 10:23
8) Neil    IN: 10:01 OUT: 10:19
9) Chris   IN: 10:10 OUT: 11:00
