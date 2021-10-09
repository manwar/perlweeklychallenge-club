#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental };

# Do Not Write Your Own Date and Time Manipulation Code!
# Do Not Write Your Own Date and Time Manipulation Code!
# Do Not Write Your Own Date and Time Manipulation Code!
# Do Not Write Your Own Date and Time Manipulation Code!
# Do Not Write Your Own Date and Time Manipulation Code!
use DateTime;

my @examples;
push @examples, '2021/09/18';
push @examples, '1975/10/10';
push @examples, '1967/07/08';
push @examples, '1970/01/01';

for my $input (@examples) {
my $output=    mirror_dates($input);
    say <<"END";
        Input:  $input
        Output: $output
END
}

# takes the date as a string, in the ONE TRUE FORMAT: YYYY/MM/DD
# That makes the epoch 1970/01/01
# The program CAN handle non-padded days and months, but when you're
# dealling with a LOT of dates, non-zero,padding makes you wonder if
# 1970123 is Jan 23 or Dec 3.
sub mirror_dates ( $date_str ) {

    # The default time zone for new DateTime objects, except where stated 
    # otherwise, is the "floating" time zone. This concept comes from the 
    # iCal standard. A floating datetime is one which is not anchored to 
    # any particular time zone. In addition, floating datetimes do not 
    # include leap seconds, since we cannot apply them without knowing the 
    # datetime's time zone.
    my $now = DateTime->now()->set_time_zone('floating');

    my ( $y, $m, $d ) = split m{/}, $date_str;
    my $then = DateTime->new(
        year      => $y,
        month     => $m,
        day       => $d,
        time_zone => 'floating'
    );

    # the time difference between now and then, expressed in days
    my $diff   = $now->delta_days($then)->in_units('days');

    # add and subtract in a DateTime context act on the object, which
    # isn't the result I would expect from $semi_numerical_thing->add(number)
    # so we clone it and modify the clone.
    # I mean, we COULD, but for testing, I was printing now and then as well
    # as past and future, just to be sure I was right.
    my $past   = $then->clone;
    $past->subtract( days => $diff );

    my $future = $now->clone;
    $future->add( days => $diff );

    return join ', ', $future->ymd, $past->ymd;
}
