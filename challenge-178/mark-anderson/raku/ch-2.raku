#!/usr/bin/env raku
use Test;

# Duration is hours only
# Holidays are not taken into account

is business-date('2022-08-01 10:30', 4),     '2022-08-01T14:30:00Z';
is business-date('2022-08-01 17:00', 3.5),   '2022-08-02T11:30:00Z';
is business-date('2022-08-05 19:00', 4.5),   '2022-08-08T13:30:00Z';
is business-date('2022-08-06 12:00', 5.5),   '2022-08-08T14:30:00Z';
is business-date('2022-08-05 09:37', 6.5),   '2022-08-05T16:07:00Z';
is business-date('2022-08-02 09:00', 28),    '2022-08-05T10:00:00Z';
is business-date('2022-08-03 09:15', 28.25), '2022-08-08T10:30:00Z';
is business-date('2022-08-03 10:59', 36.25), '2022-08-09T11:14:00Z';
is business-date('2022-08-03 11:01', 36.25), '2022-08-09T11:16:00Z';
 
sub business-date($timestamp, $duration is copy)
{
    $duration *= 3600;
    my $dt = DateTime.new($timestamp.subst(/\s/, 'T') ~ ':00Z'); 

    unless $dt.day-of-week <= 5 and [le] '09:00:00', $dt.hh-mm-ss, '18:00:00'
    {
        $dt .= later(:days<1>) if [le] '18:00:00', $dt.hh-mm-ss, '23:59:59'; 
        $dt .= later(:days<1>) while $dt.day-of-week > 5; 
        $dt .= clone(:hour<9>, :minute<0>, :second<0>)
    }

    loop
    {
        my $available = $dt.clone(:hour<18>, :minute<0>, :second<0>) - $dt;

        return $dt.later(seconds => $duration) if $duration <= $available;

        $duration -= $available;
        repeat { $dt .= later(:days<1>) } while $dt.day-of-week > 5;
        $dt .= clone(:hour<9>, :minute<0>, :second<0>)
    }   
}
