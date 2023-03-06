#!usr/bin/perl
use v5.36;

# Challenge 206 - 1 - Shortest Time
# You are given a list of time points, at least 2, in the 24-hour clock format HH:MM.
# Write a script to find out the shortest time in minutes between any two time points.


shortTime("00:00", "23:55", "20:00");
shortTime("01:01", "00:50", "00:57");
shortTime("10:10", "09:30", "09:00", "09:55");

sub shortTime(@array)
{
    foreach my $time (@array)
    {
        my ($hour, $minutes) = $time =~ m"(\d\d):(\d\d)";
        $time = $hour*60 + $minutes;
    }
    
    my $shortTime = 1440;
    
    foreach my $time (@array)
    {
        foreach my $secondTime (@array)
        {
            next if($time == $secondTime);
            
            my $tempTime = $secondTime;
            
            ($tempTime += 1440)     if($time > $secondTime);

            $shortTime = ($tempTime - $time)  if(($tempTime - $time) < $shortTime );
        }

    }
    
    say $shortTime;
}