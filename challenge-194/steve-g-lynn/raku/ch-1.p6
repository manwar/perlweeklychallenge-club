#!/usr/bin/env perl6

say &digital-clock('?5:00'); #1
say &digital-clock('?3:00'); #2
say &digital-clock('1?:00'); #9
say &digital-clock('2?:00'); #3
say &digital-clock('12:?5'); #5
say &digital-clock('12:5?'); #9

sub digital-clock (Str $time) {
    
    $time ~~ /^ <[0 .. 2 ?]> <[0  .. 9 ?]> \: <[0 .. 5 ?]> <[0 .. 9 ?]>$/ || (return "Invalid input");

    ($time ~~ /\?/) || (return "Invalid input");
    
    ( (substr($time,0,2) ~~ /^ <[0 .. 2]> <[0 .. 9]> $/) && (substr($time,0,2) > 23) ) && (return "Invalid input");

    ( (substr($time,3,2) ~~ /^ <[0 .. 5]> <[0 .. 9]> $/) && (substr($time,3,2) > 59) ) && (return "Invalid input");
    
    my @time=$time.comb;
    my (%i, %time_indx, $ctr);
    
    $ctr=0;
    
    for (@time) -> $i {
        %i{$i}++;
        %time_indx{$i}=$ctr++;
    }
    
    (return "Invalid input") unless (%i{'?'}==1);
    
    if (%time_indx{'?'}==0) {
        if (@time[1] > 3) {
            return 1;
        }
        else {
            return 2;
        }
    }
    
    if (%time_indx{'?'}==1) {
        if (@time[0] <= 1) {
            return 9;
        }
        elsif (@time[0] == 2) {
            return 3;
        }
        else { #-- shouldn't get here
            return "Something wrong";
        }
    }
    
    if (%time_indx{'?'}==2) { #-- shouldn't get here
        return "Something wrong";
    }
    
    if (%time_indx{'?'}==3) {
        return 5;
    }
    
    if (%time_indx{'?'}==4) {
        return 9;
    }    
}
    

