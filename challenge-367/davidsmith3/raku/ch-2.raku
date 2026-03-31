#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Task 2 Conflict Events
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given two events start and end time.

Write a script to find out if there is a conflict between the two events. A conflict happens when two events have some non-empty intersection.

=head3 Example 1:
Input: @event1 = ("10:00", "12:00")
       @event2 = ("11:00", "13:00")
Output: true

Both events overlap from "11:00" to "12:00".

=head3 Example 2:
Input: @event1 = ("09:00", "10:30")
       @event2 = ("10:30", "12:00")
Output: false

Event1 ends exactly at 10:30 when Event2 starts.
Since the problem defines intersection as non-empty, exact boundaries touching is not a conflict.

=head3 Example 3:
Input: @event1 = ("14:00", "15:30")
       @event2 = ("14:30", "16:00")
Output: true

Both events overlap from 14:30 to 15:30.

=head3 Example 4:
Input: @event1 = ("08:00", "09:00")
       @event2 = ("09:01", "10:00")
Output: false

There is a 1-minute gap from "09:00" to "09:01".

=head3 Example 5:
Input: @event1 = ("23:30", "00:30")
       @event2 = ("00:00", "01:00")
Output: true

They overlap from "00:00" to "00:30".

=end pod

sub convert-to-minutes(Str:D $time -->Int) {
    my ($hours, $minutes) = $time.split(":");
    ($hours * 60) + $minutes;
}

my regex hours-minutes { ^ (\d\d) ':' (\d\d) $ <?{ $0 < 24 && $1 < 60 }> };
subset Span of List where { .elems == 2 && .grep(&hours-minutes).elems == 2 };

constant MINUTES-PER-DAY = 1440;

multi my-sub(Span $event1, Span $event2 -->Bool) {
    my $e1-end = convert-to-minutes($event1[1]);
    my $e1-start = convert-to-minutes($event1[0]);
    my $e2-start = convert-to-minutes($event2[0]);

    # enforce event1 starts before event 2
    $e2-start += MINUTES-PER-DAY if $e2-start < $e1-start;
    
    $e1-end += MINUTES-PER-DAY if $e1-end < $e1-start;
    $e1-end > $e2-start;
}

multi my-sub(List $event1, List $event2 -->Bool) {
    die "Unexpected input.  Received $event1, $event2"
}

multi MAIN(Str:D $event1-start, Str:D $event1-end, Str:D $event2-start, $event2-end) {
    say my-sub(($event1-start, $event1-end), ($event2-start, $event2-end));
}

multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    plan +@tests;
    for @tests {
        is my-sub(|.<input>), .<output>, "{.<input>}";
    }
}

sub extract-tests(-->Array[Hash]) {
    my Hash @tests;
    my $list = / '(' .* ')' /;
    my $bool = / << [ [t|T] rue | [f|F] alse ] >> /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ /  ($list) .* ($list) .* ($bool)  / {
                @tests.push(%{ input => ($0.EVAL, $1.EVAL), output => $2.tc.EVAL });
            }
        }
    }
    @tests.push(%{ input => (("23:30", "00:30"), ("23:45", "01:00")), output => True });
    @tests.push(%{ input => (("23:30", "00:30"), ("01:00", "02:00")), output => False });
    @tests.push(%{ input => (("23:30", "00:30"), ("00:30", "02:00")), output => False });
    @tests.push(%{ input => (("23:30", "00:30"), ("23:30", "23:31")), output => True });
    @tests.push(%{ input => (("23:30", "00:30"), ("23:29", "23:31")), output => False });
    @tests.push(%{ input => (("01:30", "01:45"), ("01:00", "02:00")), output => False });
    @tests;
}
