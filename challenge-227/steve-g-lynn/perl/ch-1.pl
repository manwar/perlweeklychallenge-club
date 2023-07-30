#!/usr/bin/env -S perl -wl

use Date::Manip;

my $dateobj=Date::Manip::Date->new();

sub friday_13th {
    my ($year)=@_;
    my $retval=0;
    ( ($year > 9999) || ($year < 1753) ) &&
        die "Year should be between 1753 and 9999";

    map {
        ( ($dateobj->new_date("$year-$_-13")->printf('%w') ) == 5 ) &&
            $retval++;
    } 
    1 .. 12;
    
    $retval;
} 

print &friday_13th(2023); #2

