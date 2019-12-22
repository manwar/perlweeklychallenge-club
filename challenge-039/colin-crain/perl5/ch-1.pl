#! /opt/local/bin/perl
#
#       ch-1.pl
#
#       PWC 39 - TASK #1
#       A guest house had a policy that the light remain ON as long as the at
#           least one guest is in the house. There is guest book which tracks
#           all guest in/out time. Write a script to find out how long in
#           minutes the light were ON.
#               Guest Book
#               1) Alex    IN: 09:10 OUT: 09:45
#               2) Arnold  IN: 09:15 OUT: 09:33
#               3) Bob     IN: 09:22 OUT: 09:55
#               4) Charlie IN: 09:25 OUT: 10:05
#               5) Steve   IN: 09:33 OUT: 10:01
#               6) Roger   IN: 09:44 OUT: 10:12
#               7) David   IN: 09:57 OUT: 10:23
#               8) Neil    IN: 10:01 OUT: 10:19
#               9) Chris   IN: 10:10 OUT: 11:00

#
#       method: given the dataset we have, it's fairly obvious the house is
#           continuously occupied from the moment the first person enters, 9:10,
#           until the time the last person leaves, at 11.00. Roger, the 6th
#           person, makes the bridge. However we should design our software to
#           be more generally robust in counting, and have the possiblity that
#           all should leave before another arrives and the light should be
#           turned temporarily off then back on.
#
#           A few posits will need to be made before we start:
#               1. a guestbook is a series of entries, where each line is
#                   entered successively after the previous. Thus we can
#                   assume the first entry IN will be the earliest time
#                   recorded. Any time that numerically appears to be earlier
#                   is in fact rolled over midnight and after that time. The
#                   same logic applies to IN and OUT times, one must be after
#                   the other, even if numerically it seems otherwise.
#               2. that time is on a 24 hour clock, so midnight+30 would be
#                   written as 00:30. This isn't strictly necessary, but no
#                   am/pm notation is included in the times above, so if this
#                   were not true we could only count elapsed times within a
#                   12 hour block. Again, this doesn't occur in the data, and
#                   alternately adjusting the conventional notation 12:30 to
#                   mean 0 hours is straightforward, but it does seem better to
#                   either do this or add am/pm to the records. As is, if
#                   someone goes to ground for more than 12 hours in their
#                   room the system falls apart and maybe the lights go out
#                   on them. Sitting in the dark is to be avoided for
#                   reclusive shut-ins, leading to under-stimulation,
#                   oversleeping, depression and worse, so for the greater
#                   good 24 hour time it is.
#
#           When we look at the first person to come IN, then log the time that
#           person went OUT, we know the light was on throughout that time and
#           establish a basic window. We can then incrementally look through the
#           guestbook entries: if the guest entered before, and left after, the
#           end of the window we move the end time of the window up accordingly.
#           If the guest enters after the window endtime we calculate the elapsed
#           minute total for the window to that point, add it to the accumulator
#           and reset the window parameters from that guest's IN and OUT. After
#           each guest entry is processed we proceed to the next guestbook entry
#           until there are no more.
#
#           To make things a little more interesting instead of pasting and
#           reading from a __DATA__ section at the end of the script, we'll just
#           read and parse this script itself to find the above specification in
#           the challenge and config directly from that. You know, because reasons
#           or something. As is becoming usual, we will then store everything in a
#           data structure and access it from there. In this case it will be an
#           array of hashes, each containing the data for one guestbook line, with
#           keys for name, IN time, and OUT time. We don't actually use the name,
#           but it's nice to remember these are real fictional people we are
#           logging the movements of here, with names, faces, loved ones and real
#           imaginary lives. Although what they are doing ducking in a guesthouse
#           for 17 minutes is anyone's guess.
#
#           Given the constraints that no span between IN and OUT, nor span
#           between the last guest OUT and the next guest IN is greater than one
#           day, or really 23:59, the log entries can span days indefinitely. Add
#           some new entries above and you will see for yourself.
#
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## CONFIG
## times in hh:mm notation are normalized to the number of minutes from the start of the day
open (my $fh, "<", $0) or die "can't open this script thats running this code to read: $0 : $!";
my @book;
while ( my $line = <$fh> ) {
    if ($line =~ /^[)#\s\d]+(\w+)\s+IN: (\d\d:\d\d) OUT: (\d\d:\d\d)/) {
        push @book, { name => $1, IN => minutes($2), OUT => minutes($3) };
    }
}

## ## ## ## ## MAIN

## start_time establishes our initial reference window. Any timestamp less than
## start_time will in reality represent the following day and so will have 1440
## added to it.
my $start_time = $book[0]->{IN};
my $end_time   = $book[0]->{OUT};

my $accumulated_minutes;

while (scalar @book) {
    ## we shift through the guestbook entries processing them one by one

    ## correct for clock midnight rollovers. Every vertical guestbook entry
    ## succeeds the previous, and every OUT time succeeds that entry's IN time. We correct by adding one day in minutes.
    if ($book[0]->{IN} < $start_time) {
        @{$book[0]}{'IN', 'OUT'} = map { $_ + 1440 } @{$book[0]}{'IN', 'OUT'};
    }
    $book[0]->{OUT} += 1440 if $book[0]->{OUT} < $book[0]->{IN};

    ## log the minutes and restart if this entry is outside the current window
    if ($book[0]->{IN} > $end_time) {
        $accumulated_minutes += $end_time - $start_time;
        $start_time = $book[0]->{IN};
        $end_time   = $book[0]->{OUT};
        shift @book;
        next;
    }

    ## increase the window as required
    $end_time = $book[0]->{OUT} if $book[0]->{OUT} > $end_time;

    ## remove the processed entry
    shift @book;
}

## flush the current time window one last time
$accumulated_minutes += $end_time - $start_time;

say "the light was on for $accumulated_minutes minutes";

## ## ## ## ## SUBS

sub minutes {
## convert hh:mm time into minutes from 00:00
    my $time = shift;
    $time =~ s/(\d+):(\d+)/($1 * 60) + $2/e;
    return $time;
}
