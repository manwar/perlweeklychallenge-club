#!/usr/bin/env perl6


say &days_together('12-01','20-01','15-01','18-01');
#4
say &days_together('02-03','12-03','13-03','14-03');
#0
say &days_together('02-03','12-03','11-03','15-03');
#2
say &days_together('30-03','05-04','28-03','02-04');
#4

sub days_together ($foo_sd, $foo_ed, $bar_sd, $bar_ed) {
    
    #-- get the later start date
    my $later-sd = (
    (&parse-date($foo_sd) > &parse-date($bar_sd)) ??
      &parse-date($foo_sd) !!  
      &parse-date($bar_sd);
    );
    #-- get the earlier end date
     my $earlier-ed = (
    (&parse-date($foo_ed) > &parse-date($bar_ed)) ??
      &parse-date($bar_ed) !!
      &parse-date($foo_ed);
    );
    
    #-- get time between later start date and earlier end date
    #-- add 1 to Raku date difference to include both dates
    #-- return 0 if the time is negative
    
    my $retval= $earlier-ed - $later-sd;
    ($retval >= 0) ??
        (return $retval+1) !!
        (return 0); 
}

sub parse-date( $datestring ) {
    my ($day,$month)=split('-',$datestring);
    return Date.new(2022,$month,$day);
}

