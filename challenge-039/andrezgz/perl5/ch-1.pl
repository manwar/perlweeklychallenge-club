#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-039/
# Task #1
# A guest house had a policy that the light remain ON as long as the at least one guest is in the house.
# There is guest book which tracks all guest in/out time.
# Write a script to find out how long in minutes the light were ON.
# Guest Book
# 1) Alex    IN: 09:10 OUT: 09:45
# 2) Arnold  IN: 09:15 OUT: 09:33
# 3) Bob     IN: 09:22 OUT: 09:55
# 4) Charlie IN: 09:25 OUT: 10:05
# 5) Steve   IN: 09:33 OUT: 10:01
# 6) Roger   IN: 09:44 OUT: 10:12
# 7) David   IN: 09:57 OUT: 10:23
# 8) Neil    IN: 10:01 OUT: 10:19
# 9) Chris   IN: 10:10 OUT: 11:00

use strict;
use warnings;

my %log;

open my $fh, '<', shift or die "Could not open guest book file $!";
while(<$fh>){
    chomp;

    # line format
    next unless (/\d+\)\s+\w+\s+IN:\s+(\d{2}:\d{2})\s+OUT:\s+(\d{2}:\d{2})/);
    my ($new_in,$new_out) = ($1,$2);

    # in-time lesser than out-time
    die "in-time $new_in is greater than out-time $new_out" if $new_in gt $new_out;

    # flag to add the new period to the log
    my $add = 1;

    # check existent periods against the new one
    foreach my $in (keys %log){
        if ($new_in lt $in && $new_out gt $log{$in}) {
            # completely contains an existent period
            $log{$new_in} = $new_out;
            delete $log{$in};
            $add = 0;
        }
        elsif ($new_in lt $in && $new_out gt $in && $new_out le $log{$in}) {
            # extends in-time for an existent period
            $log{$new_in} = $log{$in};
            delete $log{$in};
            $add = 0;
        }
        elsif ($new_in ge $in && $new_in lt $log{$in} && $new_out gt $log{$in}) {
            # extends out-time for an existent period
            $log{$in} = $new_out;
            $add = 0;
        }
        elsif ($new_in ge $in && $new_out le $log{$in}) {
            # completely contained in an existent period
            $add = 0;
        }
        last unless $add;
    }
    # add the new period if none of the existent ones were modified
    # or it is completely contained in one of them
    $log{$new_in} = $new_out if $add;
}
close($fh);

my $total_min = 0;
print "Periods with lights ON:\n";
foreach my $in (sort keys %log ) {
    my ( $hour_in, $min_in ) = split /:/, $in;
    my ($hour_out, $min_out) = split /:/, $log{$in};
    my $minutes = ($hour_out - $hour_in) * 60 + $min_out - $min_in;
    printf "* %s to %s (%d minutes) \n", $in, $log{$in}, $minutes;
    $total_min += $minutes;
}
print "Light ON for $total_min minutes\n";

__END__
./ch-1.pl guest_book_1.txt
Periods with lights ON:
* 09:10 to 11:00 (110 minutes)
Light ON for 110 minutes

./ch-1.pl guest_book_2.txt
Periods with lights ON:
* 09:30 to 10:00 (30 minutes)
* 10:50 to 12:10 (80 minutes)
* 13:00 to 13:30 (30 minutes)
Light ON for 140 minutes
