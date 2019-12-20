# A guest house had a policy that the light remain ON as long as the at least
# one guest is in the house. There is guest book which tracks all guest in/out
# time. Write a script to find out how long in minutes the light were ON.
#
# Guest Book
#
# 1) Alex    IN: 09:10 OUT: 09:45
# 2) Arnold  IN: 09:15 OUT: 09:33
# 3) Bob     IN: 09:22 OUT: 09:55
# 4) Charlie IN: 09:25 OUT: 10:05
# 5) Steve   IN: 09:33 OUT: 10:01
# 6) Roger   IN: 09:44 OUT: 10:12
# 7) David   IN: 09:57 OUT: 10:23
# 8) Neil    IN: 10:01 OUT: 10:19
# 9) Chris   IN: 10:10 OUT: 11:00


# Instead of counting how long the lights were on we count how long the lights
# where out. In this way it's possible to count the minutes in O(n). I "assume"
# this is a the 24-hour clock.

# The current time in minutes.
my $time = 0;

# The counted minutes of darkness from 00:00 till $time.
my $time_off = 0;

# Minutes of darkness after the last guest checked out.
my $time_last = 24 * 60;

for 'guestbook.txt'.IO.lines -> $line {
    my $rs = $line ~~ /(\d+)\:(\d+)\D+(\d+)\:(\d+)/;
    my $start = 60 * Int($rs[0]) + Int($rs[1]);
    my $end = 60 * Int($rs[2]) + Int($rs[3]);

    if ($time < $start) {
        $time_off += $start - $time;
    }

    $time = $end;
    $time_last = 24 * 60 - $end;
}

$time_off += $time_last;
my $time_on = 24 * 60 - $time_off;

say "The light was on for $time_on minutes";
