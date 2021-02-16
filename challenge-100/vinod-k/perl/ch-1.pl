#!/usr/bin/perl

use strict; use warnings;

my $time = $ARGV[0];

die "Please enter the time..\n" unless($time);

if($time =~ /(am|pm)/i){
    print "Converting time from 12hrs to 24hrs format:\n";
    if ($time =~ /(\d{1,2})\:(\d{1,2})(am|pm)/){
        my ($h, $m, $t) = ($1, $2, $3);
        $h -= 12 if ($t eq 'am' && $h == 12);
        $h += 12 if ($t eq 'pm' && $h != 12);
        $h = sprintf "%02d", $h;
        print "time:$h:$m\n";
    }
} else {
    print "Converting time from 24hrs to 12hrs format:\n";
    my ($h, $m) = split(':', $time);

    if (($h < 0) || ($h > 23)) {
        print ("$h is not a valid hour");
        exit;
    }

    print "12:$m am\n" if $h == 0;
    print "$h:$m am\n" if $h < 12;
    print "$h:$m pm\n" if $h == 12;
    my $hh = $h-12;
    print "$hh:$m PM\n" if $h > 12;
}
