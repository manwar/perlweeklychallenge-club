#!/usr/bin/env perl

print &digital_clock('?5:00'),"\n"; #1
print &digital_clock('?3:00'),"\n"; #2
print &digital_clock('1?:00'),"\n"; #9
print &digital_clock('2?:00'),"\n"; #3
print &digital_clock('12:?5'),"\n"; #5
print &digital_clock('12:5?'),"\n"; #9

sub digital_clock {
    my ($time)=@_;
    
    $time =~ /^[0-2?][0-9?]:[0-5?][0-9?]$/ || (return "Invalid input");
    (substr($time,0,2) >= 24) && (return "Invalid input");
    (substr($time,3,2) > 59) && (return "Invalid input");
    
    my @time=split(//,$time);
    my (%i, %time_indx, $ctr);
    
    $ctr=0;
    
    for my $i (@time){
        $i{$i}++;
        $time_indx{$i}=$ctr++;
    }
    
    (return "Invalid input") unless ($i{'?'}==1);
    
    if ($time_indx{'?'}==0) {
        if ($time[1] > 3) {
            return 1;
        }
        else {
            return 2;
        }
    }
    
    if ($time_indx{'?'}==1) {
        if ($time[0] <= 1) {
            return 9;
        }
        elsif ($time[0] == 2) {
            return 3;
        }
        else { #-- shouldn't get here
            return "Something wrong";
        }
    }
    
    if ($time_indx{'?'}==2) { #-- shouldn't get here
        return "Something wrong";
    }
    
    if ($time_indx{'?'}==3) {
        return 5;
    }
    
    if ($time_indx{'?'}==4) {
        return 9;
    }
    
}
    

