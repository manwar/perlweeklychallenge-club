package main;

use strict;
use warnings;

use POSIX;

print find_minimum_time_difference(["00:00", "23:55", "20:00"]) . "\n";
print find_minimum_time_difference(["01:01", "00:50", "00:57"]) . "\n";

sub find_minimum_time_difference
{
    my($times_aref) = @_;

    my $minimum_diff;

    for(my $i = 0; $i < scalar(@{$times_aref}); $i++) {
        for(my $j = 0; $j < scalar(@{$times_aref}); $j++) {
            my $time_a = $times_aref->[$i];
            my $time_b = $times_aref->[$j];

            # convert 00:00 to 24:00?
            $time_a =~ s/00:00/24:00/g;
            $time_b =~ s/00:00/24:00/g;

            if($i == $j) {
                next; # skip comparing identical time differences i.e. i index = j index
            }

            if(!$minimum_diff) {
                $minimum_diff = time_diff($time_a, $time_b);
            } else {
                my $time_diff = time_diff($time_a, $time_b);

                if(number_of_minutes_in($time_diff) < number_of_minutes_in($minimum_diff)) {
                    $minimum_diff = $time_diff;
                }
            }
        }
    }

    if($minimum_diff) {
        return $minimum_diff->{'hours'} . ' hours '. $minimum_diff->{'minutes'} . ' minutes';
    }
}

sub number_of_minutes_in
{
    my($time_diff) = @_;
    return ($time_diff->{'hours'} * 60) + $time_diff->{'minutes'};
}


sub time_diff
{
    my($time_a, $time_b) = @_;

    my($hour_a, $minute_a) = split(/:/, $time_a);
    my($hour_b, $minute_b) = split(/:/, $time_b);

    my $minutes_a = ($hour_a * 60) + $minute_a;
    my $minutes_b = ($hour_b * 60) + $minute_b;

    my $diff_minutes    = abs($minutes_a - $minutes_b);
    my $hours_diff      = floor($diff_minutes / 60);
    my $minutes_diff    = $diff_minutes % 60;

    return {
        'hours'     => $hours_diff,
        'minutes'   => $minutes_diff
    };
}

1;
